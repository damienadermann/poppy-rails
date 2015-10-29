require 'spec_helper'

class Bread < Poppy::Enum
  values :white
end

class Sandwhich < ActiveRecord::Base
  include Poppy::ActiveRecord

  enumeration :bread, of: Bread
end

RSpec.describe Poppy::ActiveRecord do
  describe 'enumeration' do
    context 'with enumeration attribute' do
      let(:sandwhich) { Sandwhich.create(bread: Bread::WHITE) }

      specify 'will save and retrieve an enumeration value' do
        expect(sandwhich.bread).to eq(Bread::WHITE)
      end

      context 'with user entered value' do
        let(:sandwhich) { Sandwhich.create(bread: 'white') }
        specify 'will save and retrieve an enumeration value' do
          expect(sandwhich.bread).to eq(Bread::WHITE)
        end
      end

      context 'with invalid user value' do
        let(:sandwhich) { Sandwhich.create(bread: 'wrong') }
        specify 'will save and retrieve an enumeration value' do
          expect{ sandwhich }.to raise_error(Poppy::ActiveRecord::EnumType::InvalidEnumerationError)
        end
      end
    end
  end
end
