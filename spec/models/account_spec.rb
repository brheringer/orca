require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { build(:account) }

  context 'model validation' do

    it 'should be valid when all required fields are filled' do
      expect(subject).to be_valid
    end

    it 'should not be valid when name is blank' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'should not be valid when structure is blank' do
      subject.structure = ''
      expect(subject).to_not be_valid
    end

    it 'should not be valid when username is blank' do
      subject.username = ''
      expect(subject).to_not be_valid
    end

    it 'should not be valid when kind is nil' do
      subject.kind = nil
      expect(subject).to_not be_valid
    end
  end
end
