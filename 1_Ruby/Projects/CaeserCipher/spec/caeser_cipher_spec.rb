require_relative '../caesar_cipher'

describe '#caesar_cipher' do
  it 'shifts lowercase letters correctly' do
    expect(caesar_cipher('abc', 5)).to eq('fgh')
  end

  it 'shifts uppercase letters correctly' do
    expect(caesar_cipher('ABC', 5)).to eq('FGH')
  end

  it 'wraps from z to a' do
    expect(caesar_cipher('z', 5)).to eq('e')
  end

  it 'wraps from Z to A' do
    expect(caesar_cipher('Z', 5)).to eq('E')
  end

  it 'leaves non-letter characters unchanged' do
    expect(caesar_cipher('1a.b', 1)).to eq('1b.c')
  end

  it 'handles large shift factors' do
    expect(caesar_cipher('abc', 27)).to eq('bcd')
  end

  it 'handles negative shift factors' do
    expect(caesar_cipher('bcd', -1)).to eq('abc')
  end

  it 'handles shift factor of zero' do
    expect(caesar_cipher('abc', 0)).to eq('abc')
  end

  it 'handles empty string' do
    expect(caesar_cipher('', 5)).to eq('')
  end
end
