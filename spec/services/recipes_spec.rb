# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Recipes do
  let(:repository) { double('Repositories::RecipeRepository') }

  before :each do
    allow(described_class).to receive(:repository).and_return(repository)
  end

  it 'calls repository all method' do
    allow(repository).to receive(:all).and_return([])
    expect(described_class.all).to eq []
  end

  it 'calls repository find_by_id method' do
    allow(repository).to receive(:find_by_id).and_return(nil)
    expect(described_class.find('id')).to eq nil
  end
end
