# frozen_string_literal: true

module Primer
  # Use `Subhead` as the start of a section. The `:heading` slot will render an `<h2>` font-sized text.
  #
  # - Optionally set the `:description` slot to render a short description and the `:actions` slot for a related action.
  # - Use a succint, one-line description for the `:description` slot. For longer descriptions, omit the description slot and render a paragraph below the `Subhead`.
  # - Use the actions slot to render a related action to the right of the heading. Use <%= link_to_component(Primer::ButtonComponent) %> or <%= link_to_component(Primer::LinkComponent) %>.
  #
  # @accessibility
  #   The `:heading` slot defaults to rendering a `<div>`. Update the tag to a heading element with the appropriate level to improve page navigation for assistive technologies.
  #   <%= link_to_heading_practices %>
  class SubheadComponent < Primer::Component
    status :beta

    DEFAULT_HEADING_TAG = :div
    HEADING_TAG_OPTIONS = [DEFAULT_HEADING_TAG, :h1, :h2, :h3, :h4, :h5, :h6].freeze

    # The heading
    #
    # @param tag [Symbol] <%= one_of(Primer::SubheadComponent::HEADING_TAG_OPTIONS)%>
    # @param danger [Boolean] Whether to style the heading as dangerous.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :heading, lambda { |tag: DEFAULT_HEADING_TAG, danger: false, **system_arguments|
      system_arguments[:tag] = fetch_or_fallback(HEADING_TAG_OPTIONS, tag, DEFAULT_HEADING_TAG)
      system_arguments[:classes] = class_names(
        system_arguments[:classes],
        "Subhead-heading",
        "Subhead-heading--danger": danger
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # Actions
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :actions, lambda { |**system_arguments|
      deny_tag_argument(**system_arguments)
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(system_arguments[:classes], "Subhead-actions")

      Primer::BaseComponent.new(**system_arguments)
    }

    # The description
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :description, lambda { |**system_arguments|
      deny_tag_argument(**system_arguments)
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(system_arguments[:classes], "Subhead-description")

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.heading(tag: :h3) do %>
    #       My Heading
    #     <% end %>
    #     <% component.description do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example With dangerous heading
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.heading(tag: :h3, danger: true) do %>
    #       My Heading
    #     <% end %>
    #     <% component.description do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example With long description
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.heading(tag: :h3) do %>
    #       My Heading
    #     <% end %>
    #   <% end %>
    #   <p> This is a longer description that is sitting below the Subhead. It's much longer than a description that could sit comfortably in the Subhead. </p>
    #
    # @example Without border
    #   <%= render(Primer::SubheadComponent.new(hide_border: true)) do |component| %>
    #     <% component.heading do %>
    #       My Heading
    #     <% end %>
    #     <% component.description do %>
    #       My Description
    #     <% end %>
    #   <% end %>
    #
    # @example With actions
    #   <%= render(Primer::SubheadComponent.new) do |component| %>
    #     <% component.heading do %>
    #       My Heading
    #     <% end %>
    #     <% component.description do %>
    #       My Description
    #     <% end %>
    #     <% component.actions do %>
    #       <%= render(
    #         Primer::ButtonComponent.new(
    #           tag: :a, href: "http://www.google.com", scheme: :danger
    #         )
    #       ) { "Action" } %>
    #     <% end %>
    #   <% end %>
    #
    # @param spacious [Boolean] Whether to add spacing to the Subhead.
    # @param hide_border [Boolean] Whether to hide the border under the heading.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(spacious: false, hide_border: false, **system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)

      @system_arguments[:tag] = :div
      @system_arguments[:classes] =
        class_names(
          @system_arguments[:classes],
          "Subhead",
          "Subhead--spacious": spacious,
          "border-bottom-0": hide_border
        )
      @system_arguments[:mb] ||= hide_border ? 0 : nil
    end

    def render?
      heading.present?
    end
  end
end
