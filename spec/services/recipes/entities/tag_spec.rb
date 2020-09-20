# frozen_string_literal: true

require 'rails_helper'

describe Recipes::Entities::Tag do
  it 'create valid entity' do
    entity = described_class.new(id: 'id', name: 'Tag #1')
    expect(entity.id).to eq 'id'
    expect(entity.name).to eq 'Tag #1'
  end

  describe '.wrap_entity' do
    it 'creates valid entity' do
      params = { 'sys' => { 'id' => 'id' }, 'fields' => { 'name' => 'Tag #1' } }
      entity = described_class.wrap_entity(params)
      expect(entity.id).to eq 'id'
      expect(entity.name).to eq 'Tag #1'
    end
  end
end
