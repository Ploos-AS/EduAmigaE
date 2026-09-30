# 07 — Arrays

## Goal

Learn to store several values under one name and retrieve them with an index.

## Example

```e
PROC main()
  DEF values[5]:ARRAY, i
  values[0] := 2
  values[1] := 4
  values[2] := 6
  values[3] := 8
  values[4] := 10

  FOR i := 0 TO 4
    WriteF('\d\n', values[i])
  ENDFOR
ENDPROC
```

**Compatibility:** E33.

The array contains five elements. Its indices are 0 through 4. The loop lets the same code process each element.

## Run and change it

```sh
eduamigae build examples/07-arrays/arrays.e
eduamigae run build/arrays
```

Change the values and calculate the sum of all elements.

## Think

Why is the final valid index 4 when the array contains five elements? What can happen if code uses an index outside the range?

## Exercise

Create an array containing five numbers of your own and print them in reverse order.

## Challenge

Find the largest value in the array using a loop and a variable that holds the best value seen so far.

## Summary

Arrays collect multiple elements of the same kind of data and make loops much more useful. Indices and bounds become especially important when we later work closer to memory.
