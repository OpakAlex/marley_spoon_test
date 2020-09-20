# frozen_string_literal: true

require 'rails_helper'

describe Recipes::Entities::Asset do
  it 'create valid entity' do
    entity = described_class.new(id: 'id', url: 'url')
    expect(entity.id).to eq 'id'
    expect(entity.url).to eq 'url'
  end

  describe '.wrap_entity' do
    it 'creates valid entity and adds htts to url' do
      params = { 'sys' => { 'id' => 'id' }, 'fields' => { 'file' => { 'url' => '//url' } } }
      entity = described_class.wrap_entity(params)
      expect(entity.id).to eq 'id'
      expect(entity.url).to eq 'https://url'
    end

    it 'creates valid entity and without htts into url' do
      params = { 'sys' => { 'id' => 'id' }, 'fields' => { 'file' => { 'url' => '/url' } } }
      entity = described_class.wrap_entity(params)
      expect(entity.id).to eq 'id'
      expect(entity.url).to eq '/url'
    end
  end
end
