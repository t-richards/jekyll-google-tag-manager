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

  before do
    described_class.class_variable_set(:@@warning_shown, nil)
  end

  describe 'gem things' do
    it 'has a version number' do
      expect(described_class::VERSION).not_to be_nil
    end

    it 'has the proper superclass' do
      expect(described_class.superclass).to eq(Liquid::Tag)
    end
  end

  describe '#render' do
    context 'with valid configuration' do
      let(:context) do
        make_context({ 'tag_manager' => { 'container_id' => 'GTM-1234567' } })
      end

      it 'renders the head tag with the specified id' do
        tag = Liquid::Template.parse('{% gtm head %}')

        output = tag.render!(context)

        expect(output).to eq <<~HEAD
          <!-- Begin Jekyll GTM tag v1.0.3 -->
          <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
          new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
          j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
          'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
          })(window,document,'script','dataLayer','GTM-1234567');</script>
          <!-- End Jekyll GTM tag v1.0.3 -->
        HEAD
      end

      it 'renders the body tag with the specified id' do
        tag = Liquid::Template.parse('{% gtm body %}')

        output = tag.render!(context)

        expect(output).to eq <<~BODY
          <!-- Begin Jekyll GTM tag v1.0.3 (noscript) -->
          <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-1234567"
          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
          <!-- End Jekyll GTM tag v1.0.3 (noscript) -->
        BODY
      end
    end

    context 'with no configuration' do
      let(:context) { make_context }

      it 'produces a warning' do
        tag = Liquid::Template.parse('{% gtm body %}')

        tag.render!(context)

        expect(Jekyll.logger.messages).to match(array_including(/Using fallback: GTM-NNNNNNN/))
      end

      it 'renders with the fallback id' do
        tag = Liquid::Template.parse('{% gtm body %}')

        output = tag.render!(context)

        expect(output).to eq <<~BODY
          <!-- Begin Jekyll GTM tag v1.0.3 (noscript) -->
          <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NNNNNNN"
          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
          <!-- End Jekyll GTM tag v1.0.3 (noscript) -->
        BODY
      end
    end

    context 'with multiple tags and no config' do
      let(:context) { make_context }

      it 'produces one warning' do
        head_tag = Liquid::Template.parse('{% gtm head %}')
        body_tag = Liquid::Template.parse('{% gtm body %}')

        head_tag.render!(context)
        body_tag.render!(context)

        expect(Jekyll.logger.messages.length).to eq(2)
        expect(Jekyll.logger.messages.last).to start_with('[WARNING]')
      end
    end

    context 'with bad configuration' do
      let(:context) { make_context(Object.new) }

      it 'produces a warning' do
        tag = Liquid::Template.parse('{% gtm body %}')

        tag.render!(context)

        expect(Jekyll.logger.messages).to match(array_including(/Using fallback: GTM-NNNNNNN/))
      end

      it 'renders with the fallback id' do
        tag = Liquid::Template.parse('{% gtm body %}')

        output = tag.render!(context)

        expect(output).to eq <<~BODY
          <!-- Begin Jekyll GTM tag v1.0.3 (noscript) -->
          <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NNNNNNN"
          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
          <!-- End Jekyll GTM tag v1.0.3 (noscript) -->
        BODY
      end
    end
  end

  describe '#initialize' do
    context 'when given a valid section' do
      it 'parses the head section' do
        Liquid::Template.parse('{% gtm head %}')
      end

      it 'parses the body section' do
        Liquid::Template.parse('{% gtm body %}')
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
end
