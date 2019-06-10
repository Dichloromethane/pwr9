
#include"cycle.h"
#include<stdlib.h>

typedef struct {
  cycle_list_node *head;
  size_t total_s;
} cycle_list;

typedef struct cycle_list_node {
  size_t beg;
  size_t s;
  struct cycle_list_node *next;
} cycle_list_node;

cycle_list_node *
init_cycle_list(size_t s)
{
  cycle_list_node *first;
  cycle_list *cl;
  first = malloc(sizeof(cycle_list_node));
  first->beg = 0;
  first->s = s; 
  first->next = NULL;
  cl->head = first;
  cl->total_s = s;
  return ;
}

void
split_block(cycle_list_node *prev, cycle_list_node *curr, 
			uint64_t index_into_current)
{
  
}

uint64_t
get_next(cycle_list *cl)
{
  uint64_t target_index = random()%cl->total_s--;
  uint64_t curr_index = 0;
  uint64_t ret;
  cycle_list_node *prev, *curr;
  prev = NULL;
  curr = cl->head;
  while(1) {
	if (target_index < curr_index + curr->s) {
	  ret = curr->beg + (target_index - curr_index);  
	   
	}
  }
}

void *
get_cyclic_array(size_t s)
{

  cycle_list *cl = init_cycle_list(s);
}

