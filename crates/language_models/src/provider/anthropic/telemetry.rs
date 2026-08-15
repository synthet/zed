use anyhow;
use gpui::BackgroundExecutor;
use http_client::HttpClient;
use language_model::{ANTHROPIC_PROVIDER_ID, LanguageModel};
use std::sync::Arc;
use util::ResultExt;

#[derive(Clone, Debug)]
pub struct AnthropicEventData {
    pub completion_type: AnthropicCompletionType,
    pub event: AnthropicEventType,
    pub language_name: Option<String>,
    pub message_id: Option<String>,
}

#[derive(Clone, Debug)]
pub enum AnthropicCompletionType {
    Editor,
    Terminal,
    Panel,
}

#[derive(Clone, Debug)]
pub enum AnthropicEventType {
    Invoked,
    Response,
    Accept,
    Reject,
}

impl AnthropicCompletionType {
    #[allow(dead_code)]
    fn as_str(&self) -> &'static str {
        match self {
            Self::Editor => "natural_language_completion_in_editor",
            Self::Terminal => "natural_language_completion_in_terminal",
            Self::Panel => "conversation_message",
        }
    }
}

impl AnthropicEventType {
    #[allow(dead_code)]
    fn as_str(&self) -> &'static str {
        match self {
            Self::Invoked => "invoke",
            Self::Response => "response",
            Self::Accept => "accept",
            Self::Reject => "reject",
        }
    }
}

pub fn report_anthropic_event(
    model: &Arc<dyn LanguageModel>,
    event: AnthropicEventData,
    cx: &gpui::App,
) {
    let reporter = AnthropicEventReporter::new(model, cx);
    reporter.report(event);
}

#[derive(Clone)]
pub struct AnthropicEventReporter {
    http_client: Arc<dyn HttpClient>,
    executor: BackgroundExecutor,
    api_key: Option<String>,
    is_anthropic: bool,
}

impl AnthropicEventReporter {
    pub fn new(model: &Arc<dyn LanguageModel>, cx: &gpui::App) -> Self {
        Self {
            http_client: cx.http_client(),
            executor: cx.background_executor().clone(),
            api_key: model.api_key(cx),
            is_anthropic: model.provider_id() == ANTHROPIC_PROVIDER_ID,
        }
    }

    pub fn report(&self, event: AnthropicEventData) {
        if !self.is_anthropic {
            return;
        }
        let Some(api_key) = self.api_key.clone() else {
            return;
        };
        let client = self.http_client.clone();
        self.executor
            .spawn(async move {
                send_anthropic_event(event, client, api_key).await.log_err();
            })
            .detach();
    }
}

async fn send_anthropic_event(
    _event: AnthropicEventData,
    _client: Arc<dyn HttpClient>,
    _api_key: String,
) -> anyhow::Result<()> {
    // Synth Zed: do not send Anthropic telemetry.
    Ok(())
}
