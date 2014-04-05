require "spec_helper"

describe Document do

  its(:headline) { should be_nil }

  context 'with default document' do

    subject { Document.new(headline: 'rspec_test_document_headline', user: user) }
    let(:user) { User.new( username: 'rpec_user' ) }

    its (:headline) { should == 'rspec_test_document_headline' }

    it "should not be nil" do
      subject.should_not == nil
    end

    #it "requires a display_date" do
    #  subject.should_not be_valid
    #end

    context "with only a headline" do
      
      it "raises an error if saved without a display_date" do
        expect { document.save! }.to raise_error
      end
    end

    it "has comments" do
      comment1 = Comment.new(name: 'Test Comment1')
      comment2 = Comment.new(name: 'Test Comment2')
      document = Document.new(headline: 'Test Document', comments: [comment1, comment2])
      document.comments.should include(comment1)
      document.comments.should include(comment2)
    end

    it "changes the number of Documents" do
      document = Document.new(display_date: Date.new)
      expect { document.save }.to change { Document.count }.by(1)
    end

    it "can have an image attached" do
      
    end
  end
end