require_relative 'app'
require_relative 'node'

class InvalidIndexError < StandardError
end

class LinkedListAppCache
  attr_reader :head, :size

  def initialize(size)
    @head = nil
    @size = size
  end

  # Complexity:
  #   Time: O(n) - we always iterate over every element in the list
  #   Space: O(n) - we are creating a duplicate copy of the list in memory
  def get_background_app_list()
      current_node = @head
      app_list = []

      while current_node != nil
          app_list << current_node.data.app_id
          current_node = current_node.next
      end
      return app_list
  end

  # Complexity:
  #   Time: O(n) - we iterate through every element until it either returns the correct index or reaches the end and returns -1
  #   Space: O(1) - we are only tracking the index, no new data structures are being created
  def get_background_app_index(app_id)
      current_node = @head
      index = 0
      while current_node != nil
          if current_node.data.app_id == app_id
              return index
          else
              current_node = current_node.next
              index += 1
          end
      end
      return -1
  end

  # Complexity:
  #   Time: O(n) - we iterate through at most the size (which determines the length in the next method)
  #   Space: O(1) - no new data structures are being created
  def remove_background_app(app_index)
     raise InvalidIndexError.new("You cannot have an index less than 0") if app_index < 0

     if app_index == 0
         @head = @head.next
         return
     end

     current_node = @head
     i = 0

    while i < app_index - 1
        if current_node.next = nil
            raise InvalidIndexError.new("There is no node at the requested index: #{app_index}")
        else
            current_node = current_node.next
            i += 1
        end
    end

    self.remove_next(current_node)
  end

  def remove_next(node)
      node.next = node.next.next
  end

  # Complexity:
  #   Time: O(n) - we iterate through at most the size
  #   Space: O(1) - no new data structures are being created, just a single node
  def set_background_app_id(app_id)
    current_node = @head
    index = 1

    if @head != nil
        while current_node.next != nil
            if current_node.next.data.app_id == app_id || index == @size - 1
                self.remove_next(current_node)
                break
            end
            current_node = current_node.next
            index += 1
        end
    end

    new_node = Node.new(App.new(app_id), @head)
    @head = new_node

  end
end
