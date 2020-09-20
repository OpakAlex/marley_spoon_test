# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Recipes::Entities::Recipe do
  let(:tag) { Recipes::Entities::Tag.new(id: '1', name: 'Tag #1') }
  let(:chef) { Recipes::Entities::Chef.new(id: '1', name: 'Chef #1') }
  let(:asset) { Recipes::Entities::Asset.new(id: '1', url: 'url') }

  it 'create valid entity' do
    entity = described_class.new(
      id: 'id', title: 'Recipe #1', description: 'some',
      asset: nil, chef: nil, tags: []
    )
    expect(entity.id).to eq 'id'
    expect(entity.title).to eq 'Recipe #1'
  end

  it 'create valid entity with relations' do
    entity = described_class.new(
      id: 'id', title: 'Recipe #1', description: 'some',
      tags: [tag], chef: chef, asset: asset
    )
    expect(entity.id).to eq 'id'
    expect(entity.title).to eq 'Recipe #1'
    expect(entity.chef.name).to eq chef.name
    expect(entity.asset.url).to eq asset.url
    expect(entity.tags.first.name).to eq tag.name
  end

  describe '.wrap_entity' do
    it 'creates valid entity' do
      params = { 'sys' => { 'id' => 'id' }, 'fields' => { 'title' => 'Recipe #1', 'description' => 'some' } }
      entity = described_class.wrap_entity(params, asset, chef, [tag])
      expect(entity.id).to eq 'id'
      expect(entity.title).to eq 'Recipe #1'
      expect(entity.chef.name).to eq chef.name
      expect(entity.asset.url).to eq asset.url
      expect(entity.tags.first.name).to eq tag.name
    end
  end
end
# rubocop:enable Metrics/BlockLength
