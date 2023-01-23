CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name AS name, s.size AS size 
  FROM dogs AS d, sizes AS s
  WHERE d.height > s.min AND d.height <= s.max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT dc.name
  FROM dogs AS dc, dogs AS dp, parents AS p
  WHERE dc.name = p.child AND dp.name = p.parent 
  ORDER BY dp.height DESC;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT p1.child AS c1, p2.child AS c2 
  FROM parents AS p1, parents AS p2
  WHERE p1.parent = p2.parent AND p1.child < p2.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT s.c1 || " and " || s.c2 || " are " || sd1.size || " siblings"
  FROM siblings AS s, size_of_dogs AS sd1, size_of_dogs AS sd2
  WHERE sd1.name = s.c1 AND sd2.name = s.c2 AND sd1.size = sd2.size;


-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper1(dog1, stack_height, last_height);
CREATE TABLE stacks_helper2(dog1, dog2, stack_height, last_height);
CREATE TABLE stacks_helper3(dog1, dog2, dog3, stack_height, last_height);
CREATE TABLE stacks_helper4(dog1, dog2, dog3, dog4, stack_height, last_height);

-- Add your INSERT INTOs here
INSERT INTO stacks_helper1
SELECT name, height, height 
FROM dogs;

INSERT INTO stacks_helper2
SELECT st.dog1, d.name, st.stack_height + d.height, d.height 
FROM dogs AS d, stacks_helper1 AS st
WHERE d.height >= st.last_height AND d.name != st.dog1;

INSERT INTO stacks_helper3
SELECT st.dog1, st.dog2, d.name, st.stack_height + d.height, d.height 
FROM dogs AS d, stacks_helper2 AS st
WHERE d.height >= st.last_height AND d.name != st.dog2;

INSERT INTO stacks_helper4
SELECT st.dog1, st.dog2, st.dog3, d.name, st.stack_height + d.height, d.height 
FROM dogs AS d, stacks_helper3 AS st
WHERE d.height >= st.last_height AND d.name != st.dog3;

CREATE TABLE stacks AS
  SELECT st.dog1 || ", " || st.dog2 || ", " || st.dog3 || ", " || st.dog4, st.stack_height
  FROM stacks_helper4 AS st
  WHERE st.stack_height >= 170
  ORDER BY st.stack_height;

