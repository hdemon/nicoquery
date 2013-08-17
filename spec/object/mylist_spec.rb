require "nicoquery/object/mylist"


describe "NicoQuery::Objecct::Mylist" do
  before do
    # mylist:38369702 はテスト用に作ったマイリスト。以下の動画を含んでいる。
    # sm9 新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師
    # sm1097445 【初音ミク】みくみくにしてあげる♪【してやんよ】
    # mock = mock 'NicoQuery::Api::Mylist'
    @mylist = NicoQuery::Object::Mylist.new('38369702')
    # mock.should_receive(:initialise)
  end

  describe "movies" do
    it "returns movie instances" do
      expect(@mylist.movies).to be_an_instance_of Array
      expect(@mylist.movies[0]).to be_an_instance_of NicoQuery::Object::Movie
    end
  end

  describe "title" do
    subject { @mylist }

    it "returns string of title" do
      expect(subject.title).to eq "to_test"
    end
  end
end


# # logger.log('... Statement generated for Aslak ...') が呼ばれることを確認したい
# it "logs a message on generate()" do
#   # テストの為にcustomer.nameで'Aslak'を返しておきたいのでdouble/stub
#   customer = double('customer')
#   customer.stub(:name).and_return('Aslak')
#   # 今回の評価対象なのでmock
#   logger = mock('logger')
#   statement = Statement.new(customer, logger)
#   # logger.log('... Statement generated for Aslak ...') が呼ばれることを期待
#   logger.should_receive(:log).with(/Statement generated for Aslak/)
#   # テスト対象を実行して期待通りかテスト 
#   statement.generate
# end
