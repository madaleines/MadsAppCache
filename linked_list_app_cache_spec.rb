require 'minitest/autorun'
require 'minitest/reporters'
require "minitest/skip_dsl"

require_relative 'lib/linked_list_app_cache'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe LinkedListAppCache do
    # Arrange
    before do
        CACHE_LIMIT = 5
        @list = LinkedListAppCache.new(CACHE_LIMIT)
    end

    describe 'initialize' do
        it 'can be created' do

            # Assert
            expect(@list).must_be_kind_of LinkedListAppCache
        end
    end

    xdescribe 'set_background_app_id(app_id)' do
        it 'can add a new app' do
            # Act
            test_id = 1
            test_app = App.new(test_id)
            @list.set_background_app_id(test_app)

            # Assert
            expect(@list.first.app_id).must_equal 1
        end

        it 'will put existing app in cache to beginning' do
            # Act
            first_id = 1
            first_app = App.new(first_id)
            @list.set_background_app_id(first_app)

            second_id = 2
            second_app = App.new(second_id)
            @list.set_background_app_id(second_app)

            third_id = 3
            third_app = App.new(third_id)
            @list.set_background_app_id(third_app)
            # Assert
            expect(@list.first.app_id).must_equal third_app.app_id

            # Act again
            @list.set_background_app_id(first_app)

            # Assert
            expect(@list.first.app_id).must_equal first_app.app_id
        end
    end

    xdescribe remove_background_app(app_index) do
        it "will remove the background app by index number" do
            expect(@list.length).must_equal 0

            test_id = 1
            test_app = App.new(test_id)
            @list.set_background_app_id(test_app)

            expect(@list.length).must_equal 1

            @list.remove_background_app(0)

            expect(@list.length).must_equal 0
        end
    end

    xdescribe "get_background_app_index(app_id)" do
        it "will return the index if the app_id is in the cache" do
            test_id = 1
            test_app = App.new(test_id)
            @list.get_background_app_index(test_id).must_equal 0
        end

        it "will return -1 if the app_id is not in the cache" do
            test_id = 1
            test_app = App.new(test_id)

            dne_id = 2
            @list.get_background_app_index(dne_id).must_equal -1
        end

    end

    xdescribe 'get_background_app_list' do
        it 'returns an empty array if no apps have been opened' do
            expect(@list).must_equal []
            expect(@list).length.must_equal 0
        end

        it 'returns an array if apps have been added' do
            test_id = 1
            test_app = App.new(test_id)

            expect(@list).must_equal [test_app]
            expect(@list).length.must_equal 1
        end

        it 'does not return an array larger than the CACHE LIMIT' do
            first_id = 1
            first_app = App.new(first_id)
            @list.set_background_app_id(first_app)

            second_id = 2
            second_app = App.new(second_id)
            @list.set_background_app_id(second_app)

            third_id = 3
            third_app = App.new(third_id)
            @list.set_background_app_id(third_app)

            fourth_id = 4
            fourth_app = App.new(fourth_id)
            @list.set_background_app_id(fourth_app)

            fifth_id = 5
            fifth_app = App.new(fifth_id)
            @list.set_background_app_id(fifth_app)

            sixth_id = 6
            sixth_app = App.new(sixth_id)
            @list.set_background_app_id(sixth_app)

            expect(@list).must_equal [sixth_app, fifth_app, fourth_app, third_app, second_app]
            expect(@list).length.must_equal 5
        end
    end
end
