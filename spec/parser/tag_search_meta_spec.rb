require "spec_helper"
require "./lib/nicoquery/parser/tag_search_meta"
require "./spec/fixture/tag_search_meta"
require "pry"

describe "TagSearch::Meta" do
  before do
    @instance = NicoQuery::ObjectMapper::TagSearch::Meta.new(Fixture.tag_search_meta_xml)
  end

  # describe "tag" do
  #   subject { @instance.tag }
  #   specify { expect(subject).to be }
  # end

  describe "publish_date" do
    subject { @instance.publish_date }
    specify { expect(subject).to be_kind_of(Time) }
  end

  describe "last_build_date" do
    subject { @instance.last_build_date }
    specify { expect(subject).to be_kind_of(Time) }
  end

  # describe "item" do
  #   subject { @instance.items }
  #   specify { expect(subject).to be_kind_of(Array) }
  # end
end