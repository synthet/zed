use std::sync::Arc;

use gpui::{AnyElement, App, Empty, IntoElement, RenderOnce, Window};
use ui::prelude::*;

#[derive(IntoElement, RegisterComponent)]
pub struct EndTrialUpsell {
    dismiss_upsell: Arc<dyn Fn(&mut Window, &mut App)>,
}

impl EndTrialUpsell {
    pub fn new(dismiss_upsell: Arc<dyn Fn(&mut Window, &mut App)>) -> Self {
        Self { dismiss_upsell }
    }
}

impl RenderOnce for EndTrialUpsell {
    fn render(self, _window: &mut Window, _cx: &mut App) -> impl IntoElement {
        // Monetization upsell disabled for this fork.
        let _ = self.dismiss_upsell;
        Empty
    }
}

impl Component for EndTrialUpsell {
    fn scope() -> ComponentScope {
        ComponentScope::Agent
    }

    fn name() -> &'static str {
        "End Trial Upsell"
    }

    fn description() -> &'static str {
        "End-of-trial upsell (disabled)."
    }

    fn preview(_window: &mut Window, _cx: &mut App) -> AnyElement {
        Empty.into_any_element()
    }
}
