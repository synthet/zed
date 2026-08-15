mod cloud;

use client::{Client, UserStore};
use gpui::{App, Entity};
use std::sync::Arc;

pub fn init(_client: Arc<Client>, _user_store: Entity<UserStore>, _cx: &mut App) {
    // Local-first: do not register CloudWebSearchProvider (hosted Zed web search).
    let _ = cloud::ZED_WEB_SEARCH_PROVIDER_ID;
}
