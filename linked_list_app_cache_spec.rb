require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'lib/linked_list_app_cache'


CACHE_LIMIT = 5

describe LinkedListAppCache do
    # Arrange
    before do
        @list = LinkedListAppCache.new(CACHE_LIMIT)
    end

    describe 'initialize' do
        it 'can be created' do

            # Assert
            expect(@list).must_be_kind_of LinkedListAppCache
        end
    end

    describe 'set_background_app_id(app_id)' do
        it 'can add a new app' do
            # Act
            test_id = 1
            @list.set_background_app_id(test_id)

            # Assert
            expect(@list.get_background_app_list().first).must_equal 1
        end

        it 'will put existing app in cache to beginning' do
            # Act
            first_id = 1
            @list.set_background_app_id(first_id)

            second_id = 2
            @list.set_background_app_id(second_id)

            third_id = 3
            @list.set_background_app_id(third_id)
            # Assert
            expect(@list.get_background_app_list().first).must_equal third_id

            # Act again
            @list.set_background_app_id(first_id)

            # Assert
            expect(@list.get_background_app_list().first).must_equal first_id
        end
    end

    describe "remove_background_app(app_index)" do
        it "will remove the background app by index number" do
            expect(@list.get_background_app_list().length).must_equal 0

            test_id = 1
            @list.set_background_app_id(test_id)

            expect(@list.get_background_app_list().length).must_equal 1

            @list.remove_background_app(0)

            expect(@list.get_background_app_list().length).must_equal 0
        end

        it "raises InvalidIndexError if you try to remove an index less than 0" do
            test_id = 1
            @list.set_background_app_id(test_id)
            proc { @list.remove_background_app(-1) }.must_raise InvalidIndexError
        end
    end

    describe "get_background_app_index(app_id)" do
        it "will return the index if the app_id is in the cache" do
            test_id = 1
            @list.set_background_app_id(test_id)
            @list.get_background_app_index(test_id).must_equal 0
        end

        it "will return -1 if the app_id is not in the cache" do
            test_id = 1
            @list.set_background_app_id(test_id)

            dne_id = 2
            @list.get_background_app_index(dne_id).must_equal -1
        end
    end

    describe 'get_background_app_list' do
        it 'returns an empty array if no apps have been opened' do
            expect(@list.get_background_app_list()).must_equal []
            expect(@list.get_background_app_list().length).must_equal 0
        end

        it 'returns an array if apps have been added' do
            @list.set_background_app_id("1")

            expect(@list.get_background_app_list()).must_equal ["1"]
            expect(@list.get_background_app_list().length).must_equal 1
        end

        it 'does not return an array larger than the CACHE LIMIT' do
            @list.set_background_app_id("1")
            @list.set_background_app_id("2")
            @list.set_background_app_id("3")
            @list.set_background_app_id("4")
            @list.set_background_app_id("5")
            @list.set_background_app_id("6")

            expect(@list.get_background_app_list()).must_equal ["6", "5", "4", "3", "2"]
            expect(@list.get_background_app_list().length).must_equal CACHE_LIMIT
        end
    end
end
