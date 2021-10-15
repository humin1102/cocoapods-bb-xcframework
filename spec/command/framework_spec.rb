require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::XCFramework do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ xcframework }).should.be.instance_of Command::XCFramework
      end
    end
  end
end

