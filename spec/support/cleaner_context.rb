shared_context "shared cleaner" do
  let(:sample_array) { [data] }
  let(:result) { subject.clean sample_array }
  let(:modified_value) { result.first.first.last }
end
