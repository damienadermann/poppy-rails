require 'spec_helper'

class Bread < Poppy::Enum
  values :white
end

class Filling < Poppy::Enum
  values :pork, :chicken, :ham
end

class Sandwhich < ActiveRecord::Base
  include Poppy::ActiveRecord

  enumeration :bread, of: Bread
  enumeration :fillings, as: :array, of: Filling
end

RSpec.describe Poppy::ActiveRecord do
  describe 'enumeration' do
    let(:sandwhich) { Sandwhich.create(bread: bread, fillings: fillings) }
    let(:bread) { Bread::WHITE }
    let(:fillings) { [] }
    context 'as value' do
      specify 'will save and retrieve an enumeration value' do
        expect(sandwhich.reload.bread).to eq(Bread::WHITE)
      end

      context 'with user entered value' do
        let(:bread) { 'white' }
        specify 'will save and retrieve an enumeration value' do
          expect(sandwhich.reload.bread).to eq(Bread::WHITE)
        end
      end

      describe 'validation' do
        context 'with invalid user value' do
          let(:bread) { 'wrong' }
          specify 'will save and retrieve an enumeration value' do
            expect(sandwhich.errors[:bread]).
              to eq(['is not included in the list'])
          end
        end
      end
    end
    context 'as array' do
      let(:fillings) { [Filling::HAM, Filling::CHICKEN] }
      specify 'will save and retrieve enumeration values' do
        expect(sandwhich.reload.fillings).to match_array(fillings)
        expect(sandwhich.errors).to be_empty
      end

      context 'with user entered value' do
        let(:fillings) { ['ham', :chicken] }
        specify 'will save and retrieve enumeration values' do
          expect(sandwhich.reload.fillings).
            to match_array([Filling::HAM, Filling::CHICKEN])
        end
      end

      describe 'validation' do
        context 'with invalid user value' do
          let(:fillings) { ['wrong'] }
          specify 'will save and retrieve an enumeration value' do
            expect(sandwhich.errors[:fillings]).
              to eq(['must only only contain values of type Filling'])
          end
        end
      end
    end
  end
end
