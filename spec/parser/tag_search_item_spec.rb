require "spec_helper"
require "./lib/nicoquery/parser/tag_search_item"
require "./spec/fixture/tag_search_item"


describe "TagSearch::Item" do
  before do
    @instance_1 = NicoQuery::ObjectMapper::TagSearch::Item.new Fixture.tag_search_item_xml_1
    @instance_2 = NicoQuery::ObjectMapper::TagSearch::Item.new Fixture.tag_search_item_xml_2
    @instance_3 = NicoQuery::ObjectMapper::TagSearch::Item.new Fixture.tag_search_item_xml_3
  end

  shared_examples "url string" do
    specify { expect(subject).to match /(http|https)\:\/\/.+/ }
  end

  describe "title" do
    subject { @instance_1.title }
    specify { expect(subject).to be }
  end

  describe "video_id" do
    subject { @instance_1.video_id }
    specify { expect(subject).to match /(sm|nm)\d{1,}/ }
  end

  describe "url" do
    subject { @instance_1.url }
    it_behaves_like "url string"
  end

  describe "publish_date" do
    subject { @instance_1.url }
    it_behaves_like "url string"
  end

  describe "thumbnail_url" do
    subject { @instance_1.thumbnail_url }
    it_behaves_like "url string"
  end

  describe "length" do
    subject { @instance_1.length }
    specify { expect(subject).to be_kind_of(Fixnum) }
  end

  describe "description" do
    subject { @instance_1.description }
    specify { expect(subject).to be_kind_of(Object) }
  end

  describe "Description" do
    describe "raw_text" do
      subject { @instance_1.description.raw_text }
      specify { expect(subject).to be_kind_of(String) }
    end

    describe "text" do
      subject { @instance_1.description.text }
      specify { expect(subject).to be_kind_of(String) }
    end

    # spec/fixture.rbを参照。
    # tag_search_item_xml_1には、video_idの記載が2つある。
    describe "movie_references" do
      subject { @instance_1.description.movie_references }
      specify { expect(subject).to be_kind_of(Array) }
      specify { expect(subject.length).to eq 1 }
      specify { expect(subject[0]).to match /^(sm|nm)\d{1,}$/ }
    end

    # tag_search_item_xml_1には、'mylist/(数字)'の記載が2つある。
    describe "mylist_references" do
      subject { @instance_1.description.mylist_references }
      specify { expect(subject).to be_kind_of(Array) }
      specify { expect(subject.length).to eq 2 }
      specify { expect(subject[0]).to match /^\d{1,}$/ }
    end

    # tag_search_item_xml_2には、'co(数字)'の記載が1つある。
    describe "community_references" do
      subject { @instance_2.description.community_references }
      specify { expect(subject).to be_kind_of(Array) }
      specify { expect(subject.length).to eq 1 }
      specify { expect(subject[0]).to match /^co\d{1,}$/ }
    end

    # tag_search_item_xml_3には、'im(数字)'の記載が1つある。
    describe "seiga_references" do
      subject { @instance_3.description.seiga_references }
      specify { expect(subject).to be_kind_of(Array) }
      specify { expect(subject.length).to eq 1 }
      specify { expect(subject[0]).to match /^im\d{1,}$/ }
    end
  end
end
