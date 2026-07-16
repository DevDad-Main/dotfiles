#!/bin/bash
focused=$(i3-msg -t get_tree | python3 -c "
import sys, json
def find_focused(node):
    if node.get('focused'):
        return node
    for n in node.get('nodes', []) + node.get('floating_nodes', []):
        r = find_focused(n)
        if r:
            return r
    return None
tree = json.load(sys.stdin)
f = find_focused(tree)
print('_shrink' in f.get('marks', []) if f else False)
")
if [ "$focused" = "True" ]; then
    i3-msg '[con_mark="_shrink"] floating disable, unmark _shrink'
else
    i3-msg 'mark _shrink; floating enable; resize set 75 ppt 75 ppt; move window position center'
fi
