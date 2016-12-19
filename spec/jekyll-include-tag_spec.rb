RSpec.describe JekyllIncludeCache do
  it "initializess the cache" do
    expect(described_class.cache).to be_a(Hash)
    expect(described_class.cache).to be_empty
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
end
