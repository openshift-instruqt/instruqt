slug: developing-with-kogito-optaplanner-knapsack
id: ytvzoo1unyy4
type: track
title: OptaPlanner and Quarkus
description: |
  In this scenario, you will learn how to implement an [OptaPlanner](https://www.optaplanner.org) application on [Quarkus](https://www.quarkus.io).

  ![Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-kogito/logo.png)
  ![Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-kogito/optaPlannerLogo.png)

  ### Knapsack Problem

  The knapsack problem is a problem in combinatoral optimization: given a knapsack that can contain a maximum weight and a set of items with a certain
  weight and value, determine the combination of items to include in the knapsack that maximizes the value of the contents without exceeding the knapsack weight limit.

  ![Knapsack Problem](https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Knapsack.svg/500px-Knapsack.svg.png)

  (image source: https://commons.wikimedia.org/wiki/File:Knapsack.svg , license: https://creativecommons.org/licenses/by-sa/2.5/deed.en)

  In this example, we have ingots of different weights and values that we want to put in our knapsack. OptaPlanner will select the combination of ingots that won't exceed the knapsack's maximum weight but will provide the highest value possible.

  OptaPlanner is an A.I. constraint satisfaction solver that provides a highly scalable platform to find optimal solutions to NP-complete and NP-hard problems. OptaPlanner enables us to write these solutions in plain Java, which makes this technology available to a large group of software developers. Furthermore, the OptaPlanner Quarkus extension lets us write our OptaPlanner application as a cloud-native micro-service.

  ### Other possibilities

  Learn more at [optaplanner.org](https://optaplanner.org), [kogito.kie.org](https://kogito.kie.org), and [quarkus.io](https://quarkus.io), or just drive on and get hands-on!
icon: https://logodix.com/logo/1910931.png
level: beginner
tags:
- openshift
owner: openshift
developers:
- nvinto@redhat.com
- rjarvine@redhat.com
- dahmed@redhat.com
- kvarela@redhat.com
private: false
published: true
challenges:
- slug: 01-create-project
  id: llhfhijsrwc2
  type: challenge
  title: Step 1
  notes:
  - type: text
    contents: |
      In this scenario, you will learn how to implement an [OptaPlanner](https://www.optaplanner.org) application on [Quarkus](https://www.quarkus.io).

      ![Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-kogito/logo.png)
      ![Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-kogito/optaPlannerLogo.png)

      ### Knapsack Problem

      The knapsack problem is a problem in combinatoral optimization: given a knapsack that can contain a maximum weight and a set of items with a certain
      weight and value, determine the combination of items to include in the knapsack that maximizes the value of the contents without exceeding the knapsack weight limit.

      ![Knapsack Problem](https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Knapsack.svg/500px-Knapsack.svg.png)

      (image source: https://commons.wikimedia.org/wiki/File:Knapsack.svg , license: https://creativecommons.org/licenses/by-sa/2.5/deed.en)

      In this example, we have ingots of different weights and values that we want to put in our knapsack. OptaPlanner will select the combination of ingots that won't exceed the knapsack's maximum weight but will provide the highest value possible.

      OptaPlanner is an A.I. constraint satisfaction solver that provides a highly scalable platform to find optimal solutions to NP-complete and NP-hard problems. OptaPlanner enables us to write these solutions in plain Java, which makes this technology available to a large group of software developers. Furthermore, the OptaPlanner Quarkus extension lets us write our OptaPlanner application as a cloud-native micro-service.

      ### Other possibilities

      Learn more at [optaplanner.org](https://optaplanner.org), [kogito.kie.org](https://kogito.kie.org), and [quarkus.io](https://quarkus.io), or just drive on and get hands-on!
  assignment: |
    In this step, we will create the OptaPlanner Quarkus application skeleton.

    # The Project

    We start with a basic Maven-based Quarkus application which has been generated from the Quarkus Maven Plugin.

    # The Application You Will Build

    In this scenario, we will build an OptaPlanner application on Quarkus that will solve the knapsack problem. The knapsack problem is a problem in which we need to put ingots with a certain weight and a certain value into a knapsack in such a way that we maximize the value without exceeding the maximum knapsack weight. The knapsack problem is an _NP-complete_ problem, which means it's not solvable in polynomial time. In other words, when the size of the problem grows, the time needed to solve the problem grows exponentially. For even relatively small problems, this means that finding the best solution can take billions of years.

    OptaPlanner is an A.I. constraint satisfaction solver that enables us to find the optimal solution to these kinds of problems in the limited time at our disposal. In this scenario, we will build an OptaPlanner application that runs on Quarkus to solve this problem.


    # Creating a basic project

    The easiest way to create a new Quarkus project is to click the following Maven command:

    `mvn io.quarkus:quarkus-maven-plugin:1.7.0.Final:create \
        -DprojectGroupId=com.redhat \
        -DprojectArtifactId=knapsack-optaplanner-quarkus \
        -DclassName="com.redhat.knapsackoptaplanner.solver.KnapsackResource" \
        -Dpath="/knapsack" \
        -Dextensions="org.optaplanner:optaplanner-quarkus,org.optaplanner:optaplanner-quarkus-jackson,quarkus-resteasy-jackson,quarkus-smallrye-openapi"`


    This command uses the Quarkus Maven plugin and generates a basic Quarkus application that includes the OptaPlanner extension in the `knapsack-optaplanner-quarkus` subdirectory.

    Click the following command to remove the automatically generated unit-test classes:
    ```
    rm -rf /root/projects/kogito/knapsack-optaplanner-quarkus/src/test/java/com
    ````

    # Running the Application

    Click the following command to change directory to the `knapsack-optaplanner-quarkus` directory:

    ```
    cd /root/projects/kogito/knapsack-optaplanner-quarkus
    ```

    Click the next command to run the OptaPlanner application in Quarkus development mode. This enables us to keep the application running while we implement our application logic. OptaPlanner and Quarkus will hot reload the application (update changes while the application is running) when it is accessed and changes have been detected:

    ```
    mvn clean compile quarkus:dev
    ```

    The application starts in development mode, but returns an error that it can't find any classes annotated with `@PlanningSolution`. This is expected! We will implement these classes later.

    # Congratulations!

    We've seen how to create the skeleton of a basic OptaPlanner on Quarkus application, and start the application in Quarkus development mode.

    In the next step we'll add the domain model of our application.
  tabs:
  - title: Terminal 1
    type: terminal
    hostname: crc
  - title: Visual Editor
    type: code
    hostname: crc
    path: /root
  difficulty: basic
  timelimit: 200
- slug: 02-implement-domain-model
  id: ruzyyh7uscxp
  type: challenge
  title: Step 2
  assignment: |
    In the previous step we've created a skeleton OptaPlanner application with Quarkus and started the application in Quarkus development mode. In this step we'll create the domain model of our application.

    ## PlanningEntities and PlanningVariables

    Each OptaPlanner application has planning entities (`@PlanningEntity` annotation) and planning variables (`@PlanningVariable` annotation). Planning entities are the entities in our domain that OptaPlanner needs to plan. In the knapsack problem, these are the ingots because these are the entities that are either put into the knapsack or not.

    Planning variables are properties of a planning entity that specify a planning value that changes during planning. In the knapsack problem, this is the property that tells OptaPlanner whether or not the ingot is _selected_. That is, whether or not it is put in the knapsack. Note that in this example we have a single knapsack. If we have multiple knapsacks, the actual knapsack is the planning variable, because an ingot can be placed in different knapsacks.

    ## Ingot

    To implement the `Ingot` class, first we need to create a new package in our project:

    `mkdir -p /root/projects/kogito/knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain`

    Click on the following line to open a new `Ingot.java` file in this package: `knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/Ingot.java`

    Click _Copy to Editor_ to copy the source code into the new `Ingot.java`file.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/Ingot.java" data-target="replace">
    package com.redhat.knapsackoptaplanner.domain;

    import org.optaplanner.core.api.domain.entity.PlanningEntity;
    import org.optaplanner.core.api.domain.variable.PlanningVariable;

    /**
     * Ingot
     */
    //Add PlanningEntity annotation
    public class Ingot {

        private int weight;

        private int value;

        //Add Planning Variable annotation
        private Boolean selected;

        public Ingot() {
        }

        public int getWeight() {
            return weight;
        }

        public void setWeight(int weight) {
            this.weight = weight;
        }

        public int getValue() {
            return value;
        }

        public void setValue(int value) {
            this.value = value;
        }

        public Boolean getSelected() {
            return selected;
        }

        public void setSelected(Boolean selected) {
            this.selected = selected;
        }

    }
    </pre>

    ### Planning Entity

    We first need to tell OptaPlanner that this class is our `PlanningEntity` class. To do this, click _Copy to Editor_ to set the `@PlanningEntity` annotation on the class.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/Ingot.java" data-target="insert" data-marker="//Add PlanningEntity annotation">
    @PlanningEntity
    </pre>

    #### Planning Variable

    Next, we need to configure our planning variable. In this example, the planning variable (the property that changes during planning) is the `selected` attribute of the planning entity class. Mark this property with the `@PlanningVariable` annotation and specify the _valuerange provider_. This is the entity in our application that provides the range of possible values of our planning variable.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/Ingot.java" data-target="insert" data-marker="  //Add Planning Variable annotation">
      @PlanningVariable(valueRangeProviderRefs = "selected")
    </pre>

    In this example, because our planning variable is a `Boolean` value, the _valuerange_ is simply `true` and `false`. We will define this provider in the next step.

    ## Knapsack

    In our application, we need to have an object that defines the maximum weight of our knapsack. So we will implement a simple `Knapsack` class that has a `maxWeight` attribute that can hold this value.

    Click the following line to open a new `Knapsack.java` file in this package: `knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/Knapsack.java`

    Click _Copy to Editor_ to add a class with a single `maxWeight` attribute.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/Knapsack.java" data-target="replace">
    package com.redhat.knapsackoptaplanner.domain;

    public class Knapsack {

        private int maxWeight;

        public Knapsack() {
        }

        public int getMaxWeight() {
            return maxWeight;
        }

        public void setMaxWeight(int maxWeight) {
            this.maxWeight = maxWeight;
        }

    }
    </pre>

    ## Congratulations!

    We've implemented the domain model of our OptaPlanner Quarkus application. In the next step, we will implement the _PlanningSolution_ of our application.
  tabs:
  - title: Terminal 1
    type: terminal
    hostname: crc
  - title: Visual Editor
    type: code
    hostname: crc
    path: /root
  difficulty: basic
  timelimit: 200
- slug: 03-implement-planning-solution
  id: sxlyaufvmrtq
  type: challenge
  title: Step 3
  assignment: |
    In the previous step we've implemented the domain model of the application. Now it's time to implement the planning solution.

    ## PlanningSolution

    The planning solution of our OptaPlanner application represents both the problem (i.e. the uninitialized solution), the working solution, and the best solution which is the solution returned by OptaPlanner when solving is ended.

    The `PlanningSolution` class therefore contains:

    * The collection of planning entities that need to be planned. In this case, this is a list of `Ingots`.
    * Zero or more collections/ranges of planning variables. In this simple example we only have a range of boolean values (i.e. `true` and `false`) that indicate whether an ingot has been selected or not.
    * Possible problem fact properties. These are properties that are neither a planning entity nor a planning variable, but are required by the constraints during solving. In this example the `Knapsack` is such a property because the problem requires the maximum weight of the knapsack in the constraint evaluation.
    * The `Score` of the solution. This contains the score calculated by the OptaPlanner `ScoreCalculator` based on the hard and soft constraints.

    ## KnapsackSolution

    We will now implement the skeleton of our `KnapsackSolution` class. To do this, click the following line to create a new `KnapsackSolution.java` file: `knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/KnapsackSolution.java`

    Click _Copy to Editor_ to copy the source code into the new `KnapsackSolution.java` file.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/KnapsackSolution.java" data-target="replace">
    package com.redhat.knapsackoptaplanner.domain;

    import java.util.List;

    import org.optaplanner.core.api.domain.solution.PlanningEntityCollectionProperty;
    import org.optaplanner.core.api.domain.solution.PlanningScore;
    import org.optaplanner.core.api.domain.solution.PlanningSolution;
    import org.optaplanner.core.api.domain.solution.drools.ProblemFactProperty;
    import org.optaplanner.core.api.domain.valuerange.CountableValueRange;
    import org.optaplanner.core.api.domain.valuerange.ValueRangeFactory;
    import org.optaplanner.core.api.domain.valuerange.ValueRangeProvider;
    import org.optaplanner.core.api.score.buildin.hardsoft.HardSoftScore;

    //Add PlanningSolution annotation here
    public class KnapsackSolution {

    //Add Ingots here

    //Add Knapsack here

    //Add selected valuerangeprovider here

    //Add PlanningScore here

      public KnapsackSolution() {
      }

    //Add getters and setters here
    }
    </pre>

    To mark this class as our `PlanningSolution` class, we need to add the `@PlanningSolution` annotation:

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/KnapsackSolution.java" data-target="insert" data-marker="//Add PlanningSolution annotation here">
    @PlanningSolution
    </pre>


    ### Planning Entities

    We can now add the collection of planning entities to our class. As stated earlier, in this implementation this is a list of ingots. We also need to tell OptaPlanner that this is the collection of planning entities, and therefore need to annotate this field with the `@PlanningEntityCollectionProperty` annotation.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/KnapsackSolution.java" data-target="insert" data-marker="//Add Ingots here">
      @PlanningEntityCollectionProperty
      private List&lt;Ingot&gt; ingots;
    </pre>

    ### Valuerange Provider

    Next, we can add the _valuerange provider_ to our solution class. This is the provider of the valuerange of our `selected` planning variable that we've defined in our `Ingot` planning entity class. Because this planning variable is a boolean value, we need to create a `Boolean` value range.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/KnapsackSolution.java" data-target="insert" data-marker="//Add selected valuerangeprovider here">
      @ValueRangeProvider(id = "selected")
      public CountableValueRange<Boolean> getSelected() {
        return ValueRangeFactory.createBooleanValueRange();
      }
    </pre>

    ### Problem Facts

    The constraints that we will implement in the following step of our scenario need to know the maximum weight of our knapsack to be able to determine whether the knapsack can carry the total weight of the selected ingots. For this reason, our constraints need to have access to the `Knapsack` instance. We will therefore click _Copy to Editor_ to create a knapsack attribute in our planning solution and annotate it with the `@ProblemFactProperty` annotation (note that there is also an `@ProblemFactCollectionProperty` annotation for collections).

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/KnapsackSolution.java" data-target="insert" data-marker="//Add Knapsack here">
      @ProblemFactProperty
      private Knapsack knapsack;
    </pre>

    ### Planning Score

    The next thing we need to add is the `PlanningScore`. In this knapsack problem we have two score types: a _hard score_ and a _soft score_. In OptaPlanner, a broken hard score defines an _infeasible solution_. In our knapsack application, for example, this is the case when the total weight of the selected ingots is higher than the maximum weight of the knapsack. The soft score is the score that we want to optimize. In this example, this is the total value of the selected ingots, because we want to have a solution with the highest possible values.

    Click _Copy to Editor_ to add a `HardSoftScore` attribute to the planningsolution class and add an `@PlanningScore` annotation to this attribute.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/KnapsackSolution.java" data-target="insert" data-marker="//Add PlanningScore here">
      @PlanningScore
      private HardSoftScore score;
    </pre>

    ### Getters and Setters

    Finally, we also need to create the _getters and setters_ for our attributes.

    <pre class="file" data-filename="/knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/domain/KnapsackSolution.java" data-target="insert" data-marker="//Add getters and setters here">
      public List&lt;Ingot&gt; getIngots() {
          return ingots;
      }

      public void setIngots(List&lt;Ingot&gt; ingots) {
          this.ingots = ingots;
      }

      public Knapsack getKnapsack() {
          return knapsack;
      }

      public void setKnapsack(Knapsack knapsack) {
          this.knapsack = knapsack;
      }

      public HardSoftScore getScore() {
          return score;
      }

      public void setScore(HardSoftScore score) {
          this.score = score;
      }
    </pre>

    That's it. We're now ready to define our constraints.

    ## Congratulations!

    In this step you've implemented the `PlanningSolution` of your application. Well done! In the next step we will implement the constraints of our problem using `ConstraintStreams`.
  tabs:
  - title: Terminal 1
    type: terminal
    hostname: crc
  - title: Visual Editor
    type: code
    hostname: crc
    path: /root
  difficulty: basic
  timelimit: 200
- slug: 04-constraints
  id: lq6ahnxb4ag8
  type: challenge
  title: Step 4
  assignment: |
    In the previous step you've implemented the `PlanningSolution` of our application. We can now implement constraint rules.

    ## Constraints

    Constraints define how the score of a solution is calculated. Based on the current assignment of planning variables to planning entities, we can calculate a score for the solution using constraints. This example, as stated earlier, uses a _hard_ and _soft_ score. A _hard_ score defines an infeasible solution and the _soft_ score is the score that we want to optimize. Our constraints will calculate these scores.

    In this example we will implement two constraints. The first constraint states that a hard constraint is broken when the total weight of the selected ingots is greater than the maximum weight of the knapsack. That is, if we select ingots that have a total weight that is greater than the maximum weight of our knapsack, the solution is infeasible.

    The soft constraint, the score that we want to optimize, is the total value of the ingots. That is, we want to find the solution that maximizes our total value. For this we will implement a constraint that calculates this as a soft score.

    ## ConstraintStreams

    OptaPlanner provides various options to implement our constraints:

    * **Easy Java**: Java implementation that recalculates the full score for every move. Easy to write but extremely slow. Do not use this in production!
    * **Incremental Java**: Java implementation that does incremental score calculation on every move. Fast, but very hard to write and maintain. Not recommended!
    * **Drools**: Rule-based constraints written in DRL. Incremental and fast calculation of constraints. Requires knowledge of Drools.
    * **Constraint Streams**: Constraints written in an API inspired by Java Streams. Incremental and fast calculation of constraints. Requires knowledge of the Streams API.

    In this example we will use the Constraint Streams API.

    We will start by implementing the `ConstraintProvider`. The implementation class is automatically picked up by the OptaPlanner Quarkus runtime without the need for any configuration.

    We will implement the `KnapsackConstraintProvider` class. To do this, click the following command to create a new package in our project:

    `mkdir -p /root/projects/kogito/knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/solver`

    Now click the following path to open a new `KnapsackConstraintProvider.java` file in this package: `knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/solver/KnapsackConstraintProvider.java`

    Click _Copy to Editor_ to copy the source code into the new `KnapsackConstraintProvider.java`file.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/solver/KnapsackConstraintProvider.java" data-target="replace">
    package com.redhat.knapsackoptaplanner.solver;

    import com.redhat.knapsackoptaplanner.domain.Ingot;
    import com.redhat.knapsackoptaplanner.domain.Knapsack;

    import org.optaplanner.core.api.score.buildin.hardsoft.HardSoftScore;
    import org.optaplanner.core.api.score.stream.Constraint;
    import org.optaplanner.core.api.score.stream.ConstraintCollectors;
    import org.optaplanner.core.api.score.stream.ConstraintFactory;
    import org.optaplanner.core.api.score.stream.ConstraintProvider;

    public class KnapsackConstraintProvider implements ConstraintProvider {

        @Override
        public Constraint[] defineConstraints(ConstraintFactory constraintFactory) {
            return new Constraint[] {
                maxWeight(constraintFactory),
                maxValue(constraintFactory)
            };
        }

        /*
         * Hard constraint
         */
    //Add hard constraint here


        /*
         * Soft constraint
         */
    //Add soft constraint here


    }
    </pre>

    Click _Copy to Editor_. The hard constraint sums up the weight of all selected ingots and compares this with the maximum weight of the knapsack.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/solver/KnapsackConstraintProvider.java" data-target="insert" data-marker="//Add hard constraint here">
      private Constraint maxWeight(ConstraintFactory constraintFactory) {
        return constraintFactory.from(Ingot.class).filter(i -> i.getSelected())
                .groupBy(ConstraintCollectors.sum(i -> i.getWeight())).join(Knapsack.class)
                .filter((ws, k) -> ws > k.getMaxWeight())
                .penalize("Max Weight", HardSoftScore.ONE_HARD, (ws, k) -> ws - k.getMaxWeight());
      }
    </pre>

    Click _Copy to Editor_. The soft constraints sums up all the values of the selected ingots.

    <pre class="file" data-filename="./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/solver/KnapsackConstraintProvider.java" data-target="insert" data-marker="//Add soft constraint here">
      private Constraint maxValue(ConstraintFactory constraintFactory) {
        return constraintFactory.from(Ingot.class)
                .filter(Ingot::getSelected)
                .reward("Max Value", HardSoftScore.ONE_SOFT, Ingot::getValue);
      }
    </pre>

    ## Congratulations!

    In this step we've implemented our first OptaPlanner constraints using the `ConstraintStreams` API. In the next step we will implement our RESTful resource and test our application.
  tabs:
  - title: Terminal 1
    type: terminal
    hostname: crc
  - title: Visual Editor
    type: code
    hostname: crc
    path: /root
  difficulty: basic
  timelimit: 200
- slug: 05-implement-rest-application
  id: j9adegxiqtjt
  type: challenge
  title: Step 5
  assignment: "In the previous step we've implemented the constraints of the application
    using the `ConstraintStreams` API. We will now create the RESTful resource of
    our application and take the application for a test-drive.\n\n# KnapsackResource\n\nWhen
    we created the initial OptaPlanner Quarkus application using the Quarkus Maven
    plugin, we defined the resource class of our RESTful endpoint (being `KnapsackResource`).\n\nWe
    will now implement the skeleton of our `KnapsackSolution` class. To do this, we
    first have to open the `KnapsackResource.java` file by clicking the following
    path: `knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/solver/KnapsackResource.java`\n\nThe
    `KnapsackResource` class is implemented as a Quarkus JAX-RS service. Click _Copy
    to Editor_ to inject an OptaPlanner `SolverManager` instance to manage the `Solver`
    instances that will solve our problem.\n\n<pre class=\"file\" data-filename=\"./knapsack-optaplanner-quarkus/src/main/java/com/redhat/knapsackoptaplanner/solver/KnapsackResource.java\"
    data-target=\"replace\">\npackage com.redhat.knapsackoptaplanner.solver;\n\nimport
    java.util.UUID;\nimport java.util.concurrent.ExecutionException;\n\nimport javax.inject.Inject;\nimport
    javax.ws.rs.Consumes;\nimport javax.ws.rs.POST;\nimport javax.ws.rs.Path;\nimport
    javax.ws.rs.Produces;\nimport javax.ws.rs.core.MediaType;\n\nimport com.redhat.knapsackoptaplanner.domain.KnapsackSolution;\n\nimport
    org.optaplanner.core.api.solver.SolverJob;\nimport org.optaplanner.core.api.solver.SolverManager;\n\n\n@Path(\"/knapsack\")\n@Consumes(MediaType.APPLICATION_JSON)\n@Produces(MediaType.APPLICATION_JSON)\npublic
    class KnapsackResource {\n\n    @Inject\n    private SolverManager&lt;KnapsackSolution,
    UUID&gt; solverManager;\n\n    @POST\n    @Path(\"/solve\")\n    public KnapsackSolution
    solve(KnapsackSolution problem) {\n        UUID problemId = UUID.randomUUID();\n
    \       // Submit the problem to start solving\n        SolverJob&lt;KnapsackSolution,
    UUID&gt; solverJob = solverManager.solve(problemId, problem);\n        KnapsackSolution
    solution;\n        try {\n            // Wait until the solving ends\n            solution
    = solverJob.getFinalBestSolution();\n        } catch (InterruptedException | ExecutionException
    e) {\n            throw new IllegalStateException(\"Solving failed.\", e);\n        }\n
    \       return solution;\n    }\n}\n</pre>\n\nSolverManager accepts (uninitialized)
    PlanningSolutions the problem), and passes this problem to a managed Solver that
    runs on a separate thread to solve it. The SolverJob runs until solving ends,
    after which we can retrieve the final best solution.\n\n# Configuring the Solver\n\nOptaPlanner
    will keep solving the problem indefinitely if we don't configure a _termination
    strategy_. A _termnination strategy_ tells OptaPlanner when to stop solving, for
    example based on the number of seconds spent, or if a score has not improved in
    a specified amount of time.\n\nIn an OptaPlanner Quarkus application, we can set
    this _termination strategy_ by simply adding a configuration property in the Quarkus
    `application.properties` configuration file. Let's first open this file by clicking
    the following path: `knapsack-optaplanner-quarkus/src/main/resources/application.properties`\n\nClick
    _Copy to Editor_ to add our _termination strategy_ configuration property:\n\n<pre
    class=\"file\" data-filename=\"./knapsack-optaplanner-quarkus/src/main/resources/application.properties\"
    data-target=\"replace\">\n# Configuration file\n# key = value\nquarkus.optaplanner.solver.termination.spent-limit=10s\n</pre>\n\nThe
    `quarkus.optaplanner.solver.termination.spent-limit` property is set to 10 seconds,
    which means that the solver will stop solving after 10 seconds and return the
    best result found so far.\n\n## Running the Application\nBecause we still have
    our application running in Quarkus development mode, we can simply access the
    Swagger-UI of our application by clicking [here](https://[[CLIENT_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/swagger-ui).
    Hitting this endpoint will force the OptaPlanner Quarkus application to do a hot-reload
    and recompile and deploy the changes we made in our application \"on-the-fly\".\n\nYou
    will see our `/knapsack/solve` RESTful API listed. We can now fire a RESTful request
    with a knapsack problem to this endpoint. We will do this from the terminal using
    cURL. Note that it will take 10 seconds for the response to return because we've
    set the OptaPlanner termination strategy to 10 seconds:\n\n`curl --location --request
    POST 'http://localhost:8080/knapsack/solve' \\\n--header 'Accept: application/json'
    \\\n--header 'Content-Type: application/json' \\\n--data-raw '{\n\t\"knapsack\":
    {\n\t\t\"maxWeight\": 10\n\t},\n\t\"ingots\" : [\n\t\t{\n\t\t\t\"weight\": 4,\n\t\t\t\"value\":
    15\n\t\t},\n\t\t{\n\t\t\t\"weight\": 4,\n\t\t\t\"value\": 15\n\t\t},\n\t\t{\n\t\t\t\"weight\":
    3,\n\t\t\t\"value\": 12\n\t\t},\n\t\t{\n\t\t\t\"weight\": 3,\n\t\t\t\"value\":
    12\n\t\t},\n\t\t{\n\t\t\t\"weight\": 3,\n\t\t\t\"value\": 12\n\t\t},\n\t\t{\n\t\t\t\"weight\":
    2,\n\t\t\t\"value\": 7\n\t\t},\n\t\t{\n\t\t\t\"weight\": 2,\n\t\t\t\"value\":
    7\n\t\t},\n\t\t{\n\t\t\t\"weight\": 2,\n\t\t\t\"value\": 7\n\t\t},\n\t\t{\n\t\t\t\"weight\":
    2,\n\t\t\t\"value\": 7\n\t\t},\n\t\t{\n\t\t\t\"weight\": 2,\n\t\t\t\"value\":
    7\n\t\t}\n\t]\n}'`\n\nThe response shows which ingots have been selected. These
    ingots will have their `selected` attribute set to `true`.\n\n## Congratulations!\nYou've
    implemented the RESTful endpoint of the application, hot-reloaded the app using
    the Quarkus dev-mode and solved a knapsack problem. Well done! In the next step
    we will deploy this application to OpenShift to run our OptaPlanner solution as
    a true cloud-native application.\n"
  tabs:
  - title: Terminal 1
    type: terminal
    hostname: crc
  - title: Visual Editor
    type: code
    hostname: crc
    path: /root
  difficulty: basic
  timelimit: 200
- slug: 06-deploy-on-openshift
  id: lwv4laqc9xsq
  type: challenge
  title: Step 6
  assignment: |
    In the previous step we've implemented the RESTful resource of our OptaPlanner Quarkus application and solved a knapsack problem. In this step of the scenario, we will deploy our service to OpenShift and scale it up to be able to handle production load.

    Before getting started with this step, stop the running application in terminal 1 using `CTRL-C`.

    ## Login to OpenShift

    Click the following command.

    `oc login --server=https://[[HOST_SUBDOMAIN]]-6443-[[KATACODA_HOST]].environments.katacoda.com --insecure-skip-tls-verify=true`

    Back in the [Overview in the OpenShift Console](https://console-openshift-console-[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/k8s/ns/knapsack-optaplanner/deploymentconfigs/knapsack-optaplanner) we can see the app scaling dynamically up to 10 pods.

    This should only take a few seconds to complete the scaling. The application is now ready to take production load.

    ## Congratulations!

    In this scenario we got a glimpse of the power of OptaPlanner apps on a Quarkus runtime on OpenShift. We've packaged our Knapsack OptaPlanner solver in a container image, deployed it on OpenShift, and solved a knapsack problem. Finally, we've scaled the environment to 10 pods to be able to serve production load. Well done!
  tabs:
  - title: Terminal 1
    type: terminal
    hostname: crc
  - title: Visual Editor
    type: code
    hostname: crc
    path: /root
  difficulty: basic
  timelimit: 200
checksum: "16126557727346332669"
