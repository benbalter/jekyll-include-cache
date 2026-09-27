# frozen_string_literal: true

RSpec.describe JekyllIncludeCache do
  subject { described_class.cache }

  context "with an empty cache" do
    it "initializess the cache" do
      expect(described_class.cache).to respond_to(:[])
      expect(described_class.cache).to respond_to(:[]=)
    end
  end

  it "uses an in-memory cache" do
    expect(subject).to be_a(JekyllIncludeCache::Cache)
  end

  context "with Jekyll::Cache", :if => defined?(Jekyll::Cache) do
    it "doesn't write to Jekyll's shared caches" do
      subject["namespaced"] = "value"
      expect(Jekyll::Cache.base_cache.values).to all(satisfy { |c| !c.key?("namespaced") })
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
      JekyllIncludeCache::Tag.digest_cache[1] = { 2 => "digest" }
      Jekyll::Hooks.trigger :site, :pre_render, site, site.site_payload
    end

    it "clears the cache" do
      expect(subject.key?("foo")).not_to be_truthy
    end

    it "clears the digest cache" do
      expect(JekyllIncludeCache::Tag.digest_cache).to be_empty
    end
  end
end
