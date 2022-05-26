describe Fastlane::Actions::InnoVersioningAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The inno_versioning plugin is working!")

      Fastlane::Actions::InnoVersioningAction.run(nil)
    end
  end
end
