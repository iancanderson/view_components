# frozen_string_literal: true

require "test_helper"

class PrimerButtonComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::ButtonComponent.new) { "content" }

    assert_text("content")
  end

  def test_defaults_button_tag_with_scheme
    render_inline(Primer::ButtonComponent.new) { "content" }

    assert_selector("button.btn[type='button']")
  end

  def test_renders_a_without_button_role
    render_inline(Primer::ButtonComponent.new(tag: :a)) { "content" }

    assert_selector("a.btn")
    refute_selector("a.btn[role='button']")
    refute_selector("a[type]")
  end

  def test_renders_summary_without_button_role
    render_inline(Primer::ButtonComponent.new(tag: :summary)) { "content" }

    assert_selector("summary.btn")
    refute_selector("summary.btn[role='button']")
    refute_selector("summary[type]")
  end

  def test_renders_href
    render_inline(Primer::ButtonComponent.new(href: "www.example.com")) { "content" }

    assert_selector("button[href='www.example.com']")
  end

  def test_renders_buttons_as_a_group_item
    render_inline(Primer::ButtonComponent.new(group_item: true)) { "content" }

    assert_selector("button.btn.BtnGroup-item")
  end

  def test_falls_back_when_type_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::ButtonComponent.new(scheme: :invalid)) { "content" }

      assert_selector(".btn")
    end
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_type
    render_inline(Primer::ButtonComponent.new(scheme: :primary)) { "content" }

    assert_selector(".btn.btn-primary")
  end

  def test_falls_back_when_variant_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::ButtonComponent.new(variant: :invalid)) { "content" }

      assert_selector(".btn")
    end
  end

  def test_renders_with_the_css_class_variant_mapping_to_the_provided_variant
    render_inline(Primer::ButtonComponent.new(variant: :small)) { "content" }

    assert_selector(".btn.btn-sm")
  end

  def test_does_not_add_btn_class_if_link
    render_inline(Primer::ButtonComponent.new(scheme: :link)) { "content" }

    assert_selector(".btn-link")
    refute_selector(".btn")
  end

  def test_renders_button_block
    render_inline(Primer::ButtonComponent.new(block: true)) { "content" }

    assert_selector(".btn.btn-block")
  end

  def test_renders_button_block_with_scheme
    render_inline(Primer::ButtonComponent.new(block: true, scheme: :primary)) { "content" }

    assert_selector(".btn.btn-primary.btn-block")
  end

  def test_renders_icon
    render_inline(Primer::ButtonComponent.new) do |c|
      c.icon(icon: :star)
      "Button"
    end

    assert_selector(".btn") do
      assert_selector(".octicon.octicon-star")
      assert_text("Button")
    end
  end

  def test_renders_counter
    render_inline(Primer::ButtonComponent.new) do |c|
      c.counter(count: 10)
      "Button"
    end

    assert_selector(".btn") do
      assert_selector(".Counter", text: "10")
      assert_text("Button")
    end
  end

  def test_renders_icon_and_counter
    render_inline(Primer::ButtonComponent.new) do |c|
      c.icon(icon: :star)
      c.counter(count: 10)
      "Button"
    end

    assert_selector(".btn") do
      assert_selector(".octicon.octicon-star")
      assert_selector(".Counter", text: "10")
      assert_text("Button")
    end
  end

  def test_renders_caret
    render_inline(Primer::ButtonComponent.new(caret: true).with_content("Button"))

    assert_selector(".btn") do
      assert_text("Button")
      assert_selector(".octicon.octicon-triangle-down")
    end
  end
end
