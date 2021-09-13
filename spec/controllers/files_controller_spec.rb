RSpec.describe FilesController, type: :controller do
  describe "DELETE #destroy" do
    let(:user) { create(:user) }
    let(:question) { create(:question, :has_attached_file) }
    let(:file_id) { question.files.first.id }

    context "author" do
      before { login question.user }

      it 'deletes existing file' do
        expect do
          delete :destroy, params: { id: file_id }, format: :js
        end.to change(question.files, :count).by(-1)
      end
    end

    context "not author" do
      before { login user }

      it 'tries to delete existing file' do
        expect do
          delete :destroy, params: { id: file_id }, format: :js
        end.not_to change(question.files, :count)
      end
    end
  end
end
