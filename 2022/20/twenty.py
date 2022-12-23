class Node:
    def __init__(self, swapped=False, data=None,prev=None,next=None):
        self.data = data
        self.next = next
        self.prev = prev
        self.swapped = swapped

class LinkedList:
    def __init__(self):
        self.head = None
        self.tail = None
    def append(self, data):
        if self.head == None:
            self.head = Node(data=data,prev=None,next=None)
            return
        curr = self.head
        while curr.next != None:
            curr = curr.next
        curr.next = Node(data=data,prev=curr,next=None)
    def loop(self):
        curr = self.head
        while curr != None:
            self.tail = curr
            curr = curr.next  
    def print_list(self):
        curr = self.head
        while curr != None:
            print(curr.data)
            curr = curr.next

    def insert_element(self,prev_node,new_node,next_node):
        new_node.prev = prev_node
        new_node.next = next_node
        if prev_node == None:
            self.head = new_node
        else:
            prev_node.next = new_node
        
        if next_node == None:
            self.tail = new_node
        else:
            next_node.prev = new_node
        

    def insert_element_after_index(self,old_node,new_node):
        #assume i is positiv
        curr = old_node
        i = old_node.data
        if i > 0:
            for _ in range(0,i):
                if curr.next == None:
                    curr = self.head
                else:
                    curr = curr.next
                
                
            if curr == None:
                self.insert_element(prev_node=curr,new_node=new_node,next_node=self.head)
                return
            self.insert_element(prev_node=curr,new_node=new_node,next_node=curr.next)
        elif i < 0:
            for _ in range(0,abs(i)+1):
                
                if curr == None:
                    curr = self.tail
                else:
                    curr = curr.prev
                
            if curr == None:
                self.insert_element(prev_node=self.tail,new_node=new_node,next_node=curr)
                return
            self.insert_element(prev_node=curr.prev,new_node=new_node,next_node=curr)

    
    def delete_node(self,node):
        if node.prev == None:
            self.head = node.next
        else:
            node.prev.next = node.next
        node.next.prev = node.prev
    
    def push(self,node):
        new_node = Node(data=node.data,swapped=True)
        self.insert_element_after_index(node,new_node=new_node)
        self.delete_node(node)

    def get_next_number(self):
        curr = self.head
        while curr.next != None:
            if curr.swapped == False:
                return curr
            curr = curr.next
        return None

ll = LinkedList()

for line in open('2022/20/t.txt'):
    line = line.strip()
    ll.append(int(line))
ll.loop()
for i in range(0,7):
    next_number = ll.get_next_number()
    if next_number.data != 0:
        
        ll.push(next_number)
    else:
        next_number.swapped = True

ll.print_list()