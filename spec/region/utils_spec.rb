require 'spec_helper'

describe 'Utils' do
  it 'merge simple hashes' do
    hash_1 = { 'a' => 'old', 'b' => 'old', 'c' => 'old' }
    hash_2 = { 'a' => nil, 'b' => 'new', 'd' => 'new' }
    expected_hash = { 'a' => 'old', 'b' => 'new', 'c' => 'old', 'd' => 'new' }
    merged_hash = Thailand::Utils.deep_hash_merge [hash_1, hash_2]

    expect(merged_hash).to eql(expected_hash)
  end

  it 'merge complex hashes (recursively)' do
    hash_1 = { 'a' => { 'aa' => 'old' }, 'b' => { 'bb' => 'old' }, 'c' => 'old' }
    hash_2 = { 'a' => { 'aa' => nil }, 'b' => { 'bb' => 'new' }, 'd' => 'new' }
    expected_hash = { 'a' => { 'aa' => 'old' }, 'b' => { 'bb' => 'new' }, 'c' => 'old', 'd' => 'new' }
    merged_hash = Thailand::Utils.deep_hash_merge [hash_1, hash_2]

    expect(merged_hash).to eql(expected_hash)
  end

  it 'merges arrays of hashes using a key' do
    array_1 = [
      { 'code' => 'A', 'meta' => 'old' },
      { 'code' => 'B', 'meta' => 'old' }
    ]
    array_2 = [
      { 'code' => 'B', 'meta' => 'new' },
      { 'code' => 'C', 'meta' => 'new' }
    ]
    expected_array = [
      { 'code' => 'A', 'meta' => 'old' },
      { 'code' => 'B', 'meta' => 'new' },
      { 'code' => 'C', 'meta' => 'new' }
    ]
    merged_array = Thailand::Utils.merge_arrays_by_keys [array_1, array_2], ['code']

    expect(merged_array).to eql(expected_array)
  end
end
