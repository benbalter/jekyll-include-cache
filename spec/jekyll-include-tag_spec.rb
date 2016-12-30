RSpec.describe JekyllIncludeCache do
  context "with an empty cache" do
    before { described_class.remove_instance_variable("@cache") }

    it "initializess the cache" do
      expect(described_class.cache).to be_a(Hash)
      expect(described_class.cache).to be_empty
    end
  end

  context "with something cached" do
    before do
      described_class.instance_variable_set("@cache", { "foo" => "bar" })
    end

    it "returns the cache" do
      expect(described_class.cache).to have_key("foo")
      expect(described_class.cache["foo"]).to eql("bar")
    end
  end

  context "clearing the cache on render" do
    let(:site) { fixture_site("site") }

    before do
      described_class.instance_variable_set("@cache", { "foo" => "bar" })
      Jekyll::Hooks.trigger :site, :pre_render, site, site.site_payload
    end

    it "clears the cache" do
      expect(described_class.cache).to eql({})
    end
  end
end
