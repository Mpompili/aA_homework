class Stack
   def initialize
     @stack = []
     # create ivar to store stack here!
   end

   def add(el)
     @stack << el
     el
     # adds an element to the stack
   end

   def remove
     @stack.pop
     # removes one element from the stack
   end

   def show
     @stack.dup
     # return a copy of the stack
   end
 end

 class Queue
    def initialize
      @queue = []
      # create ivar to store stack here!
    end

    def enqueue(el)
      @queue << el
      el
      # adds an element to the stack
    end

    def dequeue
      @queue.shift
      # removes one element from the stack
    end

    def show
      @queue.dup
      # return a copy of the stack
    end
  end

  class Map
     def initialize
       @map = []
       # create ivar to store map here!
     end

     def assign(key, value)
      pair = @map.index { |set| set[0] == key }
        if pair
          @map[pair][1] = value
        else
          @map.push([key,value])
        end
       # adds an element to the map
     end

     def lookup(key)
       @map.each do |set|
         return set[1] if set[0] == key
       end
       # removes one element from the map
     end

     def remove(key)
       @map.select { |set| set[0] != key }
      # return a copy of the stack
     end

     def show
       @map.dup
       # return a copy of the stack
     end
   end
