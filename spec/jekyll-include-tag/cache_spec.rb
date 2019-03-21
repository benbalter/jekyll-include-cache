# frozen_string_literal: true

RSpec.describe JekyllIncludeCache::Cache do
  before { subject["foo"] = "bar" }

  it "sets" do
    subject["foo2"] = "bar2"
    cache = subject.instance_variable_get("@cache")
    expect(cache["foo2"]).to eql("bar2")
  end

  it "gets" do
    expect(subject["foo"]).to eql("bar")
  end

  it "raises when a key doesn't exist" do
    expect { subject["doesnt_exist"] }.to raise_error(RuntimeError)
  end

  it "knows if a key exists" do
    expect(subject.key?("foo")).to be_truthy
    expect(subject.key?("bar")).to be_falsy
  end

  it "deletes" do
    subject["foo2"] = "bar2"
    expect(subject.key?("foo2")).to be_truthy
    subject.delete("foo2")
    expect(subject.key?("foo2")).to be_falsy
  end

  it "clears" do
    expect(subject.key?("foo")).to be_truthy
    subject.clear
    cache = subject.instance_variable_get("@cache")
    expect(cache).to eql({})
  end

  context "getset" do
    it "returns an existing value" do
      value = subject.getset "foo" do
        "bar2"
      end

      expect(value).to eql("bar")
    end

    it "sets a new value" do
      value = subject.getset "foo3" do
        "bar3"
      end

      expect(value).to eql("bar3")
      expect(subject["foo3"]).to eql("bar3")
    end
  end
end
