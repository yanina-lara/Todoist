require 'rails_helper'

RSpec.describe "Test from model task", Task, type: :model do
  it 'can create with valid attributes' do
    expect(FactoryBot.create(:task)).to be_valid.and be_an_instance_of(Task)
  end

  it 'validate status' do
    status = Faker::Number.between(from: 2, to: 100)
    expect { FactoryBot.create(:task, status: status) }.to raise_error(ArgumentError)
  end

  it 'validate title' do
    expect { FactoryBot.create(:task, title: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'validate level' do
    level = Faker::Number.between(from: 6, to: 1000)
    expect { FactoryBot.create(:task, level: level) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'validate user' do
    expect { FactoryBot.create(:task, user_id: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  context 'associations' do
    let(:task) { FactoryBot.create :task }
    subject { task }

    it 'with user' do
      should belong_to(:user) 
    end
    it 'with tag_tasks' do
      should have_many(:tag_tasks)
    end
  end
end
