require "test_helper"

class Jekyll::GoogleTagManagerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Jekyll::GoogleTagManager::VERSION
  end

  def test_body_template_path
    tag = Jekyll::GoogleTagManager.parse("gtm", "body", nil, nil)
    assert(tag.template_path.end_with?(
      "jekyll-google-tag-manager/lib/template-body.html"
    ))
  end

  def test_head_template_path
    tag = Jekyll::GoogleTagManager.parse("gtm", "head", nil, nil)
    assert(tag.template_path.end_with?(
      "jekyll-google-tag-manager/lib/template-head.html"
    ))
  end
end
