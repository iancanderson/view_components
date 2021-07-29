---
title: UnderlinePanel
componentId: underline_panel
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/underline_panel.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-underline-panel
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `UnderlinePanel` to style tabs with an associated panel and an underlined selected state.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label` | `String` | N/A | Used to set the `aria-label` on top level element. |
| `align` | `Symbol` | `:left` | One of `:left` and `:right`. - Defaults to left |
| `body_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the body wrapper. |
| `wrapper_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the `TabContainer` wrapper. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Use to render a button and an associated panel slot. See the example below or refer to [NavigationTab](/components/navigationtab).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `id` | `String` | N/A | Unique ID of tab. |
| `panel_id` | `String` | N/A | Unique ID of panel. |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Actions`

Use actions for a call to action.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:div` | One of `:div` and `:span`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="      Panel 1      Panel 2<tab-container data-view-component='true'>  <div data-view-component='true' class='UnderlineNav'>  <ul role='tablist' aria-label='With panels' data-view-component='true' class='UnderlineNav-body UnderlineNav-body list-style-none list-style-none'>      <li role='presentation' data-view-component='true' class='d-inline-flex'>  <button id='tab-1' type='button' role='tab' aria-controls='panel-1' aria-selected='true' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Tab 1</span>    </button></li>      <li role='presentation' data-view-component='true' class='d-inline-flex'>  <button id='tab-2' type='button' role='tab' aria-controls='panel-2' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Tab 2</span>    </button></li></ul>    <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>    Button!  </button></div></div>    <div id='panel-1' role='tabpanel' tabindex='0' aria-labelledby='tab-1' data-view-component='true'>      Panel 1</div>    <div id='panel-2' role='tabpanel' tabindex='0' hidden='hidden' aria-labelledby='tab-2' data-view-component='true'>      Panel 2</div></tab-container>" />

```erb
<%= render(Primer::Alpha::UnderlinePanel.new(label: "With panels")) do |component| %>
  <% component.tab(id: "tab-1", panel_id: "panel-1", selected: true) do |t| %>
    <% t.text { "Tab 1" } %>
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% component.tab(id: "tab-2", panel_id: "panel-2") do |t| %>
    <% t.text { "Tab 2" } %>
    <% t.panel do %>
      Panel 2
    <% end %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```