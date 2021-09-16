# frozen_string_literal: true

RSpec.describe JekyllIncludeCache do
  subject { described_class.cache }

  context "with an empty cache" do
    it "initializess the cache" do
      expect(described_class.cache).to respond_to(:[])
      expect(described_class.cache).to respond_to(:[]=)
    end
  end

  context "with something cached" do
    before { subject["foo"] = "bar" }

    it "caches" do
      expect(subject.key?("foo")).to be_truthy
    end

    it "returns the cache" do
      expect(subject["foo"]).to eql("bar")
    end
  end

  context "clearing the cache on render" do
    let(:site) { fixture_site("site") }

    before do
      subject["foo"] = "bar"
      Jekyll::Hooks.trigger :site, :pre_render, site, site.site_payload
    end

    it "clears the cache" do
      expect(subject.key?("foo")).not_to be_truthy
    end
  end
end
