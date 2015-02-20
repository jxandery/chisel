gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './chisel'

class ChiselTest < Minitest::Test

  def test_identifies_chunks_of_text
    # setup
    # exercise
    # expectation

    chisel = Chisel.new
    assert_equal 2, chisel.id_chunks("Level 2\n\n- Formatting").count
  end

  def test_it_replaces_one_hashtag_with_one_header_tag
    chisel = Chisel.new
    assert_equal ["<h1>", "Level", "2", "</h1>"], chisel.header_tags("# Level 2")
  end

  def test_it_replaces_multiple_hashtags_with_multiple_header_tags
    chisel = Chisel.new
    assert_equal ["<h2>", "Level", "2", "</h2>"], chisel.header_tags("## Level 2")
    assert_equal ["<h3>", "Level", "2", "</h3>"], chisel.header_tags("### Level 2")
  end

  def test_it_attaches_paragraph_tags
    chisel = Chisel.new
    assert_equal ["\n\n<p>\n", "Level", "2", "\n</p>"], chisel.paragraph_tags("Level 2")
  end

  def test_it_assigns_header_paragraph_tags
    chisel = Chisel.new
    assert_equal "<h2>Level 2</h2>\n\n<p>\nChapter 1\n</p>",
    chisel.html_tags("## Level 2\nChapter 1")
  end

  def test_it_joins_with_proper_spacing
    chisel = Chisel.new
    assert_equal ["#", "Level ", "2 ", "Chapter", "1"],
    chisel.proper_spacing("# Level 2 Chapter 1".split)
  end

  def test_emphasis_wraps_work
    chisel = Chisel.new
    assert_equal "What happens in <em>Vegas</em> ...", chisel.emphasis_wraps("What happens in *Vegas* ...")
  end

  def test_strong_wraps_work
    chisel = Chisel.new
    assert_equal "I am woman hear me <strong>ROAR</strong>!", chisel.strong_wraps("I am woman hear me **ROAR**
  end

end

