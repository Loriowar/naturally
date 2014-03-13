require 'naturally-unicode'

describe NaturallyUnicode do
  describe '#sort' do
    it 'sorts an array of strings nicely as if they were legal numbers' do
      a = %w[676 676.1 676.11 676.12 676.2 676.3 676.9 676.10]
      b = %w[676 676.1 676.2 676.3 676.9 676.10 676.11 676.12]
      NaturallyUnicode.sort(a).should == b
    end
    
    it 'sorts a smaller array of strings nicely as if they were legal numbers' do
      a = %w[676 676.1 676.11 676.12 676.2 676.3 676.9]
      b = %w[676 676.1 676.2 676.3 676.9 676.11 676.12]
      NaturallyUnicode.sort(a).should == b
    end
    
    it 'sorts a more complex list of strings' do
      a = %w[350 351 352 352.1 352.5 353.1 354 354.3 354.4 354.45 354.5]
      b = %w[350 351 352 352.1 352.5 353.1 354 354.3 354.4 354.5 354.45]
      NaturallyUnicode.sort(a).should == b
    end

    it 'sorts when numbers have letters in them' do
      a = %w[335 335.1 336a 336 337 337a 337.1 337.15 337.2]
      b = %w[335 335.1 336 336a 337 337.1 337.2 337.15 337a]
      NaturallyUnicode.sort(a).should == b
    end

    it 'sorts when numbers have unicode letters in them' do
      a = %w[335 335.1 336a 336 337 337я 337.1 337.15 337.2]
      b = %w[335 335.1 336 336a 337 337.1 337.2 337.15 337я]
      NaturallyUnicode.sort(a).should == b
    end

    it 'sorts when letters have numbers in them' do
      a = %w[PC1, PC3, PC5, PC7, PC9, PC10, PC11, PC12, PC13, PC14, PROF2, PBLI, SBP1, SBP3]
      b = %w[PBLI, PC1, PC3, PC5, PC7, PC9, PC10, PC11, PC12, PC13, PC14, PROF2, SBP1, SBP3]
      NaturallyUnicode.sort(a).should == b
    end

    it 'sorts when letters have numbers and uncode characters in them' do
      a = %w[АБ4, АБ2, АБ10, АБ12, АБ1, АБ3, АД8, АД5, АЩФ12, АЩФ8, ЫВА1]
      b = %w[АБ1, АБ2, АБ3, АБ4, АБ10, АБ12, АД5, АД8, АЩФ8, АЩФ12, ЫВА1]
      NaturallyUnicode.sort(a).should == b
    end
    
    it 'sorts double digits with letters correctly' do
      a = %w[12a 12b 12c 13a 13b 2 3 4 5 10 11 12]
      b = %w[2 3 4 5 10 11 12 12a 12b 12c 13a 13b]
      NaturallyUnicode.sort(a).should == b
    end

    it 'sorts double digits with unicode letters correctly' do
      a = %w[12а 12б 12в 13а 13б 2 3 4 5 10 11 12]
      b = %w[2 3 4 5 10 11 12 12а 12б 12в 13а 13б]
      NaturallyUnicode.sort(a).should == b
    end
  end
  
  describe '#normalize' do
    Thing = Struct.new(:number, :name)

    it 'enables sorting objects by one particular attribute' do
      objects = [
        Thing.new('1.1', 'color'),
        Thing.new('1.2', 'size'),
        Thing.new('1.1.1', 'opacity'),
        Thing.new('1.1.2', 'lightness'),
        Thing.new('1.10', 'hardness'),
        Thing.new('2.1', 'weight'),
        Thing.new('1.3', 'shape')
        ]
      sorted = objects.sort_by{ |o| NaturallyUnicode.normalize(o.number) }
      sorted.map{|o| o.name}.should == %w[
        color
        opacity
        lightness
        size
        shape
        hardness
        weight
        ]
    end

    it 'enables sorting objects by one particular attribute which contain unicode characters' do
      objects = [
          Thing.new('1.1', 'Москва'),
          Thing.new('1.2', 'Киев'),
          Thing.new('1.1.1', 'Париж'),
          Thing.new('1.1.2', 'Будапешт'),
          Thing.new('1.10', 'Брест'),
          Thing.new('2.1', 'Калуга'),
          Thing.new('1.3', 'Васюки')
      ]
      sorted = objects.sort_by{ |o| NaturallyUnicode.normalize(o.name) }
      sorted.map{|o| o.name}.should == %w[
        Брест
        Будапешт
        Васюки
        Калуга
        Киев
        Москва
        Париж
        ]
    end
  end
end