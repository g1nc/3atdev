require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PaymentsHelper. For example:
#
# describe PaymentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SalariesHelper, type: :helper do
  before { @salary = create(:salary)}

  describe '#format_starts' do
    it 'return formatted date' do
      expect(helper.format_starts @salary).to eq(@salary.starts_at.strftime("%b %d, %Y"))
    end
  end

  describe '#format_ends' do
    it 'return formatted date' do
      expect(helper.format_ends @salary).to eq(@salary.ends_at.strftime("%b %d, %Y"))
    end
  end
end
