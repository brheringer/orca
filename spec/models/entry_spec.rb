require 'rails_helper'

RSpec.describe Entry, type: :model do
  subject { build(:entry) }

  context 'model validation' do

    it 'should be valid when all required fields are filled' do
      expect(subject).to be_valid
    end

    it 'should not be valid when date is nil' do
      subject.date = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid when expected value is nil' do
      subject.expected_value = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid when actual value is nil' do
      subject.actual_value = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid when username is blank' do
      subject.username = ''
      expect(subject).to_not be_valid
    end

    it 'should not be valid when account is nil' do
      subject.account = nil
      expect(subject).to_not be_valid
    end
  end
end
