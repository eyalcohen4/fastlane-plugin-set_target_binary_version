describe Fastlane::Actions::SetTargetBinaryVersionAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The set_target_binary_version plugin is working!")

      Fastlane::Actions::SetTargetBinaryVersionAction.run(nil)
    end
  end
end
