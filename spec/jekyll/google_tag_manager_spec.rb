# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Jekyll::GoogleTagManager do
  let(:gtm_tag) do
    described_class.parse(
      'gtm',
      'body',
      Liquid::Tokenizer.new(''),
      Liquid::ParseContext.new
    )
  end

  before(:each) do
    described_class.class_variable_set(:@@warning_shown, nil)
  end

  context 'gem things' do
    it 'has a version number' do
      expect(described_class::VERSION).to_not be_nil
    end

    it 'has the proper superclass' do
      expect(described_class.superclass).to eq(Liquid::Tag)
    end
  end

  describe '#template_path' do
    it 'produces the correct path for the body' do
      body_tag = Jekyll::GoogleTagManager.parse(
        'gtm',
        'body',
        Liquid::Tokenizer.new(''),
        Liquid::ParseContext.new
      )

      expect(body_tag.template_path).to end_with('lib/template-body.html')
    end

    it 'produces the correct path for the head' do
      head_tag = described_class.parse(
        'gtm',
        'head',
        Liquid::Tokenizer.new(''),
        Liquid::ParseContext.new
      )

      expect(head_tag.template_path).to end_with('lib/template-head.html')
    end
  end

  describe '#container_id' do
    context 'with good config' do
      config = {
        'google' => {
          'tag_manager' => {
            'container_id' => 'correct'
          }
        }
      }

      it 'fetches the container id' do
        expect(gtm_tag.container_id(config)).to eq('correct')
      end
    end

    context 'with bad config' do
      config = {
        'google' => {
          'tag_manager' => {
            'false_container_thing' => 'derp'
          }
        }
      }

      it 'falls back to the placeholder id' do
        expect(gtm_tag.container_id(config)).to eq('GTM-NNNNNNN')
      end
    end

    context 'with an incorrect config type' do
      config = []

      it 'uses the fallback id' do
        expect(gtm_tag.container_id(config)).to eq('GTM-NNNNNNN')
      end

      it 'produces a warning' do
        expected_warning = <<~WARNING
          [WARNING]: jekyll-google-tag-manager
            Your GTM container id is malformed or missing.
            Using fallback: GTM-NNNNNNN
        WARNING
        expected_warning += ' '

        gtm_tag.container_id(config)

        expect(Jekyll.logger.messages.first).to eq(expected_warning)
      end
    end

    context 'with an empty configuration' do
      config = {}

      it 'uses the fallback id' do
        expect(gtm_tag.container_id(config)).to eq('GTM-NNNNNNN')
      end

      it 'produces a warning' do
        gtm_tag.container_id(config)

        expect(Jekyll.logger.messages).to match(array_including(/Using fallback: GTM-NNNNNNN/))
      end
    end

    it 'only shows the warning once' do
      tag2 = described_class.parse(
        'gtm',
        'body',
        Liquid::Tokenizer.new(''),
        Liquid::ParseContext.new
      )
      config = {}

      gtm_tag.container_id(config)
      tag2.container_id(config)

      expect(Jekyll.logger.messages.length).to eq(1)
      expect(Jekyll.logger.messages.first).to start_with('[WARNING]')
    end
  end

  describe '#render' do
    context 'with good liquid context' do
      let(:context) { make_context }

      it 'renders the head tag properly' do
        tag = Liquid::Template.parse('{% gtm head %}')

        output = tag.render!(context)

        expect(output).to include('script')
        expect(output).to include('gtm.js')
      end

      it 'renders the head tag properly' do
        tag = Liquid::Template.parse('{% gtm body %}')

        output = tag.render!(context)

        expect(output).to include('iframe')
        expect(output).to include('ns.html')
      end
    end

    context 'with bad liquid context' do
      let(:context) { make_bad_context }

      it 'handles the malformed config gracefully' do
        tag = Liquid::Template.parse('{% gtm body %}')

        tag.render!(context)

        expect(Jekyll.logger.messages).to match(array_including(/Using fallback: GTM-NNNNNNN/))
      end
    end
  end

  describe '#payload' do
    let(:context) { make_context }

    it 'has desired properties' do
      allow(gtm_tag).to receive(:context).and_return(context)

      expect(gtm_tag.payload).to eq(
        'container_id' => 'GTM-NNNNNNN',
        'gtm_tag' => {
          'version' => '1.0.3'
        }
      )
    end
  end

  context 'when given an invalid section' do
    it 'raises an error' do
      section_msg = <<~MSG
        Invalid section specified: foobar.
        Please specify one of the following sections: body, head
      MSG

      expect do
        Liquid::Template.parse('{% gtm foobar %}')
      end.to raise_error(Jekyll::GoogleTagManager::InvalidSectionError, section_msg)
    end
  end
end
