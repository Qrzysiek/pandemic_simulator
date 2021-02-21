(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 12.2' *)

(***************************************************************************)
(*                                                                         *)
(*                                                                         *)
(*  Under the Wolfram FreeCDF terms of use, this file and its content are  *)
(*  bound by the Creative Commons BY-SA Attribution-ShareAlike license.    *)
(*                                                                         *)
(*        For additional information concerning CDF licensing, see:        *)
(*                                                                         *)
(*         www.wolfram.com/cdf/adopting-cdf/licensing-options.html         *)
(*                                                                         *)
(*                                                                         *)
(***************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1088,         20]
NotebookDataLength[    289632,       6463]
NotebookOptionsPosition[    289822,       6452]
NotebookOutlinePosition[    290282,       6469]
CellTagsIndexPosition[    290239,       6466]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["Pandemic simulator (v.0.6)", "Section",
 CellID->296662264,ExpressionUUID->"2daafac9-dd3f-47a6-8226-e0800096b956"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", 
   RowBox[{
    RowBox[{
    "README", "\[IndentingNewLine]", "Evaluation", " ", "is", " ", "now", " ",
      "done", " ", "through", " ", "functions", " ", 
     RowBox[{"c", "[", "\"\<doSomething\>\"", "]"}]}], ",", " ", 
    RowBox[{
    "while", " ", "UI", " ", "updates", " ", "are", " ", "governed", " ", 
     "by", " ", "Dynamic", " ", "or", " ", 
     RowBox[{"Dynamic", "[", 
      RowBox[{"Refresh", "[", 
       RowBox[{"...", ",", 
        RowBox[{"TrackedSymbols", "\[RuleDelayed]", 
         RowBox[{"{", "symbolsToTrack", "}"}]}]}], "]"}], "]"}], 
     "\[IndentingNewLine]", "Sometimes", " ", "there", " ", "are", " ", 
     "benefits", " ", "to", " ", "explicitly", " ", "stating", " ", "the", 
     " ", 
     RowBox[{"TrackedSymbols", ".", " ", "Moreover"}], " ", "in", " ", "the", 
     " ", "case", " ", "of", " ", "graph", " ", "updating", " ", 
     "SynchronousUpdating", " ", "is", " ", "set", " ", "to", " ", "false", 
     "\[IndentingNewLine]", "which", " ", "on", " ", 
     RowBox[{"(", 
      RowBox[{"at", " ", "least", " ", "my", " ", "system"}], ")"}], " ", 
     "makes", " ", "the", " ", "time", " ", "slider", " ", "updates", " ", 
     RowBox[{"smoother", ".", " ", "In"}], " ", "case", " ", "of", " ", 
     "problems", " ", "enable", " ", 
     RowBox[{"SynchronousUpdating", ".", "\[IndentingNewLine]", "Sometimes"}],
      " ", "there", " ", "might", " ", "be", " ", "timeouts"}], ",", " ", 
    RowBox[{
    "cure", " ", "for", " ", "this", " ", "would", " ", "be", " ", "to", " ", 
     "set", " ", "DynamicEvaluationTimeout", " ", "flag", " ", "to", " ", 
     "some", " ", "larger", " ", 
     RowBox[{"number", ".", "\[IndentingNewLine]", "An"}], " ", "important", 
     " ", 
     RowBox[{"note", ":", " ", 
      RowBox[{
      "If", " ", "you", " ", "need", " ", "to", " ", "initiate", " ", 
       "dynamic", " ", "variables", " ", "that", " ", "go", " ", "to", " ", 
       "sliders", " ", "do", " ", "that", " ", "in", " ", "Initialization", 
       " ", "on", " ", "the", " ", 
       RowBox[{"bottom", "."}]}]}]}]}], "\[IndentingNewLine]", "*)"}], 
  "\[IndentingNewLine]", 
  RowBox[{"DynamicModule", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
     "n", ",", "\[Rho]", ",", "k", ",", "network", ",", "graph", ",", 
      "\[IndentingNewLine]", "initialList", ",", "p", ",", "t", ",", 
      "\[IndentingNewLine]", "\[Lambda]", ",", "o", ",", "d", ",", "g", ",", 
      "\[IndentingNewLine]", "detCanInfect", ",", "\[IndentingNewLine]", 
      "courseOfEpidemics", ",", "\[IndentingNewLine]", "size", ",", "tmax", 
      ",", "ls", ",", "stats", ",", "statsLock", ",", "groups", ",", "c", ",",
       "status", ",", 
      RowBox[{"locks", "=", 
       RowBox[{"{", "}"}]}], ",", "locksTmp", ",", "merge", ",", "merge2", 
      ",", "gColors", ",", "CommunityQ"}], "}"}], ",", "\[IndentingNewLine]", 
    
    RowBox[{"(*", 
     RowBox[{"controller", " ", "functions"}], "*)"}], "\[IndentingNewLine]", 
    
    RowBox[{
     RowBox[{
      RowBox[{"c", "[", "\"\<graph\>\"", "]"}], ":=", 
      RowBox[{"(", 
       RowBox[{"graph", "=", 
        RowBox[{"Graph", "[", 
         RowBox[{
          RowBox[{"GraphPostprocess", "@", 
           RowBox[{"(", 
            RowBox[{
             RowBox[{"graphs", "[", "network", "]"}], "[", 
             RowBox[{"n", ",", "\[Rho]", ",", "k"}], "]"}], ")"}]}], ",", 
          RowBox[{"BaseStyle", "\[Rule]", 
           RowBox[{"EdgeForm", "[", "]"}]}], ",", 
          RowBox[{"VertexSize", "\[Rule]", ".6"}], ",", 
          RowBox[{"ImageSize", "\[Rule]", 
           RowBox[{"{", " ", 
            RowBox[{"previewSize", ",", "previewSize"}], "}"}]}], ",", 
          RowBox[{"VertexStyle", "\[Rule]", 
           RowBox[{"colors", "[", "3", "]"}]}], ",", 
          RowBox[{"EdgeStyle", "\[Rule]", 
           RowBox[{"Lighter", "[", 
            RowBox[{"colors", "[", "3", "]"}], "]"}]}], ",", 
          RowBox[{"ImageMargins", "\[Rule]", "0"}], ",", 
          RowBox[{"ImagePadding", "\[Rule]", "0"}]}], "]"}]}], ")"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"c", "[", "\"\<initial\>\"", "]"}], ":=", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"initialList", "=", 
         RowBox[{"ConstantArray", "[", 
          RowBox[{"3", ",", 
           RowBox[{"VertexCount", "[", "graph", "]"}]}], "]"}]}], ";", 
        "\[IndentingNewLine]", 
        RowBox[{"Do", "[", 
         RowBox[{
          RowBox[{
           RowBox[{"initialList", "[", 
            RowBox[{"[", "i", "]"}], "]"}], "=", "1"}], ",", 
          RowBox[{"{", 
           RowBox[{"i", ",", 
            RowBox[{"RandomChoice", "[", 
             RowBox[{
              RowBox[{"Range", "[", 
               RowBox[{"VertexCount", "[", "graph", "]"}], "]"}], ",", 
              RowBox[{"Ceiling", "[", "p", "]"}]}], "]"}]}], "}"}]}], "]"}]}],
        ")"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"c", "[", "\"\<simulation\>\"", "]"}], ":=", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{
         RowBox[{"{", 
          RowBox[{"courseOfEpidemics", ",", "ls", ",", "size", ",", "tmax"}], 
          "}"}], "=", 
         RowBox[{"(", 
          RowBox[{"simulation", "[", 
           RowBox[{
           "graph", ",", "initialList", ",", "\[Lambda]", ",", "g", ",", "d", 
            ",", "o", ",", "detCanInfect", ",", "None", ",", "hardtmax"}], 
           "]"}], ")"}]}], ";", "\[IndentingNewLine]", 
        RowBox[{"stats", "=", 
         RowBox[{
          RowBox[{"(", 
           RowBox[{
            RowBox[{
             RowBox[{
              RowBox[{"statify", "[", "#", "]"}], "/", "size"}], "&"}], "/@", 
            "courseOfEpidemics"}], ")"}], "\[Transpose]"}]}], ";"}], ")"}]}], 
     ";", "\[IndentingNewLine]", "\[IndentingNewLine]", 
     RowBox[{"(*", 
      RowBox[{
      "auto", " ", "definition", " ", "of", " ", "lockdown", " ", "buttons"}],
       "*)"}], "\[IndentingNewLine]", 
     RowBox[{"Do", "[", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{
        RowBox[{"With", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"name", "=", 
             RowBox[{
              RowBox[{"Keys", "[", "lsStrategies", "]"}], "[", 
              RowBox[{"[", "i", "]"}], "]"}]}], ",", 
            RowBox[{"strat", "=", 
             RowBox[{
              RowBox[{"Values", "[", "lsStrategies", "]"}], "[", 
              RowBox[{"[", "i", "]"}], "]"}]}]}], "}"}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{
            RowBox[{"c", "[", "\"\<addLS\>\"", "]"}], "[", "name", "]"}], ":=", 
           RowBox[{"(", 
            RowBox[{
             RowBox[{"AppendTo", "[", 
              RowBox[{"locks", ",", 
               RowBox[{
                RowBox[{
                 RowBox[{"{", 
                  RowBox[{"name", ",", 
                   RowBox[{"#", "[", 
                    RowBox[{"[", "1", "]"}], "]"}], ",", 
                   RowBox[{"simulation", "[", 
                    RowBox[{"graph", ",", 
                    RowBox[{"#", "[", 
                    RowBox[{"[", "2", "]"}], "]"}], 
                    RowBox[{"(*", "initialList", "*)"}], ",", "\[Lambda]", 
                    ",", "g", ",", "d", ",", "o", ",", "detCanInfect", ",", 
                    "strat", ",", "hardtmax"}], "]"}]}], "}"}], "&"}], "@", 
                RowBox[{"FirstLockdownStep", "[", 
                 RowBox[{"strat", ",", "courseOfEpidemics", ",", "size"}], 
                 "]"}]}]}], "]"}], ";", "\[IndentingNewLine]", 
             RowBox[{"AppendTo", "[", 
              RowBox[{
               RowBox[{"locks", "[", 
                RowBox[{"[", 
                 RowBox[{"-", "1"}], "]"}], "]"}], ",", 
               RowBox[{
                RowBox[{"(", 
                 RowBox[{
                  RowBox[{
                   RowBox[{
                    RowBox[{"statify", "[", "#", "]"}], "/", "size"}], "&"}], 
                  "/@", 
                  RowBox[{
                   RowBox[{
                    RowBox[{"locks", "[", 
                    RowBox[{"[", 
                    RowBox[{"-", "1"}], "]"}], "]"}], "[", 
                    RowBox[{"[", "3", "]"}], "]"}], "[", 
                   RowBox[{"[", "1", "]"}], "]"}]}], ")"}], 
                "\[Transpose]"}]}], "]"}], ";"}], "\[IndentingNewLine]", 
            ")"}]}]}], "]"}], ";"}], "\[IndentingNewLine]", ",", 
       RowBox[{"{", 
        RowBox[{"i", ",", "1", ",", 
         RowBox[{"Length", "@", 
          RowBox[{"Keys", "[", "lsStrategies", "]"}]}]}], "}"}]}], "]"}], ";",
      "\[IndentingNewLine]", "\[IndentingNewLine]", 
     RowBox[{"(*", 
      RowBox[{"to", " ", 
       RowBox[{"shuffle", "/", "recalc"}], " ", "lockdowns"}], "*)"}], 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"c", "[", "\"\<locksRedo\>\"", "]"}], ":=", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"If", "[", 
         RowBox[{
          RowBox[{
           RowBox[{"Length", "[", "locks", "]"}], ">", "0"}], ",", " ", 
          RowBox[{
           RowBox[{"locksTmp", "=", 
            RowBox[{"locks", "[", 
             RowBox[{"[", 
              RowBox[{"All", ",", "1"}], "]"}], "]"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"locks", "=", 
            RowBox[{"{", "}"}]}], ";", 
           RowBox[{"locks", "=", 
            RowBox[{"{", "}"}]}], ";", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{
             RowBox[{"(", 
              RowBox[{
               RowBox[{
                RowBox[{"c", "[", "\"\<addLS\>\"", "]"}], "[", "#", "]"}], 
               ";"}], ")"}], "&"}], "/@", "locksTmp"}]}]}], "]"}], ";"}], 
       ")"}]}], ";", "\[IndentingNewLine]", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"c", "[", "\"\<all\>\"", "]"}], ":=", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"c", "[", "\"\<graph\>\"", "]"}], ";", 
        RowBox[{"c", "[", "\"\<initial\>\"", "]"}], ";", 
        RowBox[{"c", "[", "\"\<simulation\>\"", "]"}], ";", 
        RowBox[{"c", "[", "\"\<locksRedo\>\"", "]"}], ";"}], ")"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"c", "[", "\"\<pop\>\"", "]"}], ":=", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"c", "[", "\"\<initial\>\"", "]"}], ";", 
        RowBox[{"c", "[", "\"\<simulation\>\"", "]"}], ";", 
        RowBox[{"c", "[", "\"\<locksRedo\>\"", "]"}], ";"}], ")"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"c", "[", "\"\<evo\>\"", "]"}], ":=", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"c", "[", "\"\<simulation\>\"", "]"}], ";", 
        RowBox[{"c", "[", "\"\<locksRedo\>\"", "]"}], ";"}], ")"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{"c", "[", "\"\<refreshColors\>\"", "]"}], ":=", 
      "\[IndentingNewLine]", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"gColors", "=", "colors"}], ";", "\[IndentingNewLine]", 
        RowBox[{"If", "[", 
         RowBox[{"merge", ",", 
          RowBox[{
           RowBox[{
            RowBox[{"gColors", "[", "1", "]"}], "=", 
            RowBox[{"Blend", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"colors", "[", "1", "]"}], ",", 
               RowBox[{"colors", "[", "2", "]"}]}], "}"}], "]"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"gColors", "[", "2", "]"}], "=", 
            RowBox[{"gColors", "[", "1", "]"}]}], ";"}]}], "]"}], ";", 
        "\[IndentingNewLine]", 
        RowBox[{"If", "[", 
         RowBox[{"merge2", ",", 
          RowBox[{
           RowBox[{
            RowBox[{"gColors", "[", "4", "]"}], "=", 
            RowBox[{"Blend", "[", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"colors", "[", "4", "]"}], ",", 
               RowBox[{"colors", "[", "5", "]"}]}], "}"}], "]"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"gColors", "[", "5", "]"}], "=", 
            RowBox[{"gColors", "[", "4", "]"}]}], ";"}]}], "]"}], ";"}], 
       ")"}]}], ";", "\[IndentingNewLine]", 
     RowBox[{"FinishDynamic", "[", "]"}], ";", "\[IndentingNewLine]", 
     RowBox[{"Deploy", "@", 
      RowBox[{"Grid", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"Panel", "@", 
             RowBox[{"Grid", "[", 
              RowBox[{
               RowBox[{"{", "\[IndentingNewLine]", 
                RowBox[{
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Style", "[", 
                    RowBox[{
                    "\"\<Network Parameters\>\"", ",", "Bold", ",", "16"}], 
                    "]"}], "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Parameters that regulate shape and size of the \
networks.\>\""}], "]"}], "&"}]}], ",", "regularParams"}], "]"}]}], "}"}], ",",
                  "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"Item", "[", "\"\<\>\"", "]"}], ",", 
                   RowBox[{"Item", "[", "\"\<\>\"", "]"}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Population size: \>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Maximal number of the nodes in the network. In \
random networks, e.g. \\\"Holed Grid\\\" the number of nodes can be lower \
than this.\>\""}], "]"}], "&"}]}], ",", 
                   RowBox[{"slN", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"n", ",", "True", ",", "allowed"}], "}"}], ",", 
                    RowBox[{"c", "[", "\"\<all\>\"", "]"}]}], " ", "]"}]}], 
                  "}"}], ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Network type: \>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{"#", ",", "\"\<Choose the type of network.\>\""}],
                     "]"}], " ", "&"}]}], ",", 
                   RowBox[{"RadioButtonBar", "[", 
                    RowBox[{
                    RowBox[{"Dynamic", "[", 
                    RowBox[{"network", ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{"network", "=", "#"}], ")"}], "&"}], ",", 
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{"network", "=", "#"}], ";", " ", 
                    RowBox[{"c", "[", "\"\<all\>\"", "]"}]}], ")"}], "&"}]}], 
                    "}"}]}], "]"}], ",", 
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"#", "->", 
                    RowBox[{"Tooltip", "[", 
                    RowBox[{"#", ",", 
                    RowBox[{"graphTooltip", "[", "#", "]"}]}], "]"}]}], "&"}],
                     "/@", 
                    RowBox[{"Keys", "[", "graphs", "]"}]}], ")"}], ",", 
                    RowBox[{"Appearance", "\[Rule]", 
                    RowBox[{"\"\<Vertical\>\"", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"Automatic", ",", "2"}], "}"}]}]}]}], "]"}]}], 
                  "}"}], ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Show communities:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Changes layout of graph from grid embedding into \
embedding where communities are separated.\>\""}], "]"}], "&"}]}], ",", 
                   RowBox[{"Checkbox", "[", 
                    RowBox[{
                    RowBox[{"Dynamic", "[", "CommunityQ", "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"False", ",", "True"}], "}"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<\[Rho]:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Dynamic", "[", 
                    RowBox[{"Tooltip", "[", 
                    RowBox[{"#", ",", 
                    RowBox[{"\[Rho]Tooltip", "[", "network", "]"}]}], "]"}], 
                    "]"}], "&"}]}], ",", 
                   RowBox[{"sl", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{
                    "\[Rho]", ",", "0.001", ",", "1", ",", "0.001", ",", 
                    RowBox[{"Dynamic", "[", 
                    RowBox[{"rhoEnabled", "[", "network", "]"}], "]"}]}], 
                    "}"}], ",", 
                    RowBox[{"c", "[", "\"\<all\>\"", "]"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<k: \>\"", "//", 
                    RowBox[{
                    RowBox[{"Dynamic", "[", 
                    RowBox[{"Tooltip", "[", 
                    RowBox[{"#", ",", 
                    RowBox[{"kTooltip", "[", "network", "]"}]}], "]"}], "]"}],
                     "&"}]}], ",", 
                   RowBox[{"sl", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"k", ",", "1", ",", "6", ",", "1", ",", 
                    RowBox[{"Dynamic", "[", 
                    RowBox[{"kEnabled", "[", "network", "]"}], "]"}]}], "}"}],
                     ",", 
                    RowBox[{"c", "[", "\"\<all\>\"", "]"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Button", "[", 
                    RowBox[{"\"\<Reshuffle network\>\"", ",", 
                    RowBox[{"c", "[", "\"\<all\>\"", "]"}]}], "]"}], "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Pick new random graph with the same parameters and \
redo the simulation.\>\""}], "]"}], "&"}]}], ",", "regularParams"}], "]"}]}], 
                  "}"}], ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"Item", "[", "\"\<\>\"", "]"}], ",", 
                   RowBox[{"Item", "[", "\"\<\>\"", "]"}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Style", "[", 
                    RowBox[{
                    "\"\<Epidemic Parameters\>\"", ",", "Bold", ",", "16"}], 
                    "]"}], "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", "\"\<Set the parameters of the disease.\>\""}], 
                    "]"}], "&"}]}], ",", "regularParams"}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Number of \\ninitially infected:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Set how many people are initially infected.\>\""}], 
                    "]"}], "&"}]}], ",", 
                   RowBox[{"sl", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"p", ",", "1", ",", "10", ",", "1"}], "}"}], ",", 
                    
                    RowBox[{"c", "[", "\"\<pop\>\"", "]"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Button", "[", 
                    RowBox[{"\"\<Reshuffle initially infected\>\"", ",", 
                    RowBox[{"c", "[", "\"\<pop\>\"", "]"}]}], "]"}], "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Pick new set of nodes that are initially infected \
for the same graph and redo the simulation.\>\""}], "]"}], "&"}]}], ",", 
                    "regularParams"}], "]"}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Infection rate:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Parameter that describes how fast the infection \
spreads. The bigger, the faster it is.\>\""}], "]"}], "&"}]}], ",", 
                   RowBox[{"hg", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{
                    "\[Lambda]", ",", "1", ",", "0.001", ",", "0.9", ",", 
                    "0.001"}], "}"}], ",", 
                    RowBox[{"c", "[", "\"\<evo\>\"", "]"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Detection rate:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Parameter that describes how fast we detect the \
infected nodes. The bigger, the faster they get detected.\>\""}], "]"}], 
                    "&"}]}], ",", 
                   RowBox[{"hg", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{
                    "o", ",", "2", ",", "0.001", ",", "0.9", ",", "0.001"}], 
                    "}"}], ",", 
                    RowBox[{"c", "[", "\"\<evo\>\"", "]"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Recovery rate:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Parameter that describes how fast the infected can \
recover. The bigger, the faster they can recover.\>\""}], "]"}], "&"}]}], ",", 
                   RowBox[{"hg", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{
                    "g", ",", "4", ",", "0.001", ",", "0.3", ",", "0.001"}], 
                    "}"}], ",", 
                    RowBox[{"c", "[", "\"\<evo\>\"", "]"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Death rate:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Parameter that describes how fast the infected can \
die. The bigger, the faster they can die.\>\""}], "]"}], "&"}]}], ",", 
                   RowBox[{"hg", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{
                    "d", ",", "5", ",", "0.001", ",", "0.3", ",", "0.001"}], 
                    "}"}], ",", 
                    RowBox[{"c", "[", "\"\<evo\>\"", "]"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Button", "[", 
                    RowBox[{"\"\<Reshuffle the course of epidemic\>\"", ",", 
                    RowBox[{"c", "[", "\"\<evo\>\"", "]"}]}], "]"}], "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Pick a new course of epidemics with the same \
parameters, graph and initially infected.\>\""}], "]"}], "&"}]}], ",", 
                    "regularParams"}], "]"}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"Item", "[", "\"\<\>\"", "]"}], ",", 
                   RowBox[{"Item", "[", "\"\<\>\"", "]"}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"(*", 
                  RowBox[{
                   RowBox[{"{", 
                    RowBox[{"\"\<\>\"", ",", 
                    RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{"Style", "[", 
                    RowBox[{
                    "\"\<Display Parameters\>\"", ",", "Bold", ",", "16"}], 
                    "]"}], ",", "regularParams"}], "]"}]}], "}"}], ","}], 
                  "*)"}], "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Display groups:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Pick which groups should be displayed on the \
graph.\>\""}], "]"}], "&"}]}], ",", 
                   RowBox[{"Row", "[", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"TogglerBar", "[", 
                    RowBox[{
                    RowBox[{"Dynamic", "[", "groups", "]"}], ",", 
                    "groupAssoc", ",", "regularParams"}], "]"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"Column", "[", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Dynamic", "@", 
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"MemberQ", "[", 
                    RowBox[{"groups", ",", "1"}], "]"}], "&&", 
                    RowBox[{"MemberQ", "[", 
                    RowBox[{"groups", ",", "2"}], "]"}]}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"Row", "[", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Checkbox", "[", 
                    RowBox[{
                    RowBox[{"Dynamic", "[", 
                    RowBox[{"merge", ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{"merge", "=", "#"}], ")"}], "&"}], ",", 
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{"merge", "=", "#"}], ";", 
                    RowBox[{"c", "[", "\"\<refreshColors\>\"", "]"}], ";"}], 
                    ")"}], "&"}]}], "}"}]}], "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"False", ",", "True"}], "}"}]}], "]"}], ",", 
                    RowBox[{"\"\<Merge inf & det\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Display Infected and Detected together.\>\""}], 
                    "]"}], "&"}]}]}], "}"}], "]"}], ",", 
                    RowBox[{
                    RowBox[{"merge", "=", "False"}], ";", "\"\<\>\""}]}], 
                    "]"}]}], ",", "\[IndentingNewLine]", 
                    RowBox[{"Dynamic", "@", 
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"MemberQ", "[", 
                    RowBox[{"groups", ",", "4"}], "]"}], "&&", 
                    RowBox[{"MemberQ", "[", 
                    RowBox[{"groups", ",", "5"}], "]"}]}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"Row", "[", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Checkbox", "[", 
                    RowBox[{
                    RowBox[{"Dynamic", "[", 
                    RowBox[{"merge2", ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{"merge2", "=", "#"}], ")"}], "&"}], ",", 
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{"merge2", "=", "#"}], ";", 
                    RowBox[{"c", "[", "\"\<refreshColors\>\"", "]"}], ";"}], 
                    ")"}], "&"}]}], "}"}]}], "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"False", ",", "True"}], "}"}]}], "]"}], ",", 
                    RowBox[{"\"\<Merge rec & dead\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Display Recovered and Dead together.\>\""}], "]"}], 
                    "&"}]}]}], "}"}], "]"}], ",", 
                    RowBox[{
                    RowBox[{"merge2", "=", "False"}], ";", "\"\<\>\""}]}], 
                    "]"}]}]}], "}"}], "]"}]}], "}"}], "]"}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"Item", "[", "\"\<\>\"", "]"}], ",", 
                   RowBox[{"Item", "[", "\"\<\>\"", "]"}]}], "}"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Style", "[", 
                    RowBox[{
                    "\"\<Countermeasures\>\"", ",", "Bold", ",", "16"}], 
                    "]"}], "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", "\"\<Ways to fight with the epidemics.\>\""}], 
                    "]"}], "&"}]}], ",", "regularParams"}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"\"\<Quarantine for detected:\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Check how putting detected to the quarantine changes \
the course of epidemics.\>\""}], "]"}], "&"}]}], ",", 
                   RowBox[{"Checkbox", "[", 
                    RowBox[{
                    RowBox[{"Dynamic", "[", 
                    RowBox[{"detCanInfect", ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{"detCanInfect", "=", "#"}], ")"}], "&"}], ",", 
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{"detCanInfect", "=", "#"}], ";", 
                    RowBox[{"c", "[", "\"\<evo\>\"", "]"}]}], ")"}], "&"}]}], 
                    "}"}]}], "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"True", ",", "False"}], "}"}]}], "]"}]}], "}"}], 
                 ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{"ActionMenu", "[", 
                    RowBox[{
                    RowBox[{"\"\<Add lockdown strategy\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Check how given lockdown strategy changes the course \
of epidemics, assuming everyone is grounded.\>\""}], "]"}], "&"}]}], ",", 
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"#", "\[RuleDelayed]", 
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"c", "[", "\"\<addLS\>\"", "]"}], "[", "#", "]"}],
                     ";"}], ")"}]}], "&"}], "/@", 
                    RowBox[{"Keys", "[", "lsStrategies", "]"}]}], ")"}], ",", 
                    
                    RowBox[{"Appearance", "\[Rule]", "\"\<PopupMenu\>\""}]}], 
                    "]"}], ",", "regularParams"}], "]"}]}], "}"}], 
                 "\[IndentingNewLine]", ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Dynamic", "@", 
                    RowBox[{"Column", "@", 
                    RowBox[{"Table", "[", 
                    RowBox[{
                    RowBox[{"Row", "[", 
                    RowBox[{"With", "[", 
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"j", "=", "j"}], "}"}], ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"Button", "[", 
                    RowBox[{"\"\<X\>\"", ",", 
                    RowBox[{"locks", "=", 
                    RowBox[{"Delete", "[", 
                    RowBox[{"locks", ",", "j"}], "]"}]}]}], "]"}], ",", 
                    RowBox[{"locks", "[", 
                    RowBox[{"[", 
                    RowBox[{"j", ",", "1"}], "]"}], "]"}]}], "}"}]}], "]"}], 
                    "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"j", ",", "1", ",", 
                    RowBox[{"Length", "[", "locks", "]"}]}], "}"}]}], 
                    "]"}]}]}]}], "}"}], ",", "\[IndentingNewLine]", 
                 RowBox[{"{", 
                  RowBox[{"\"\<\>\"", ",", 
                   RowBox[{"Item", "[", 
                    RowBox[{
                    RowBox[{"Button", "[", 
                    RowBox[{
                    RowBox[{"\"\<Reshuffle lockdowns\>\"", "//", 
                    RowBox[{
                    RowBox[{"Tooltip", "[", 
                    RowBox[{
                    "#", ",", 
                    "\"\<Recalculate the epidemics during lockdown, without \
recalculating the original course of epidemics.\>\""}], "]"}], "&"}]}], ",", 
                    RowBox[{"c", "[", "\"\<locksRedo\>\"", "]"}]}], "]"}], 
                    ",", "regularParams"}], "]"}]}], "}"}]}], 
                "\[IndentingNewLine]", "}"}], ",", 
               RowBox[{"Spacings", "\[Rule]", 
                RowBox[{"{", 
                 RowBox[{"2", ",", " ", ".5"}], "}"}]}], ",", 
               RowBox[{"Alignment", "\[Rule]", 
                RowBox[{"{", 
                 RowBox[{"{", 
                  RowBox[{"Right", ",", "Left"}], "}"}], "}"}]}], ",", 
               RowBox[{"ItemSize", "\[Rule]", 
                RowBox[{"{", 
                 RowBox[{"{", 
                  RowBox[{"16", ",", "Automatic"}], "}"}], "}"}]}], ",", 
               RowBox[{"ItemStyle", "\[Rule]", "\"\<Text\>\""}]}], "]"}]}], 
            ",", "\[IndentingNewLine]", 
            RowBox[{"Column", "[", 
             RowBox[{"{", "\[IndentingNewLine]", 
              RowBox[{
               RowBox[{"Legended", "[", 
                RowBox[{
                 RowBox[{"Dynamic", "[", 
                  RowBox[{
                   RowBox[{"Refresh", "[", "\[IndentingNewLine]", 
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{"CommunityQ", ",", 
                    RowBox[{"(*", 
                    RowBox[{
                    "This", " ", "is", " ", "for", " ", "proper", " ", 
                    "vertex", " ", "scaling", " ", "in", " ", "random", " ", 
                    "graphs"}], "*)"}], "\[IndentingNewLine]", 
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{"commEnabled", "[", "network", "]"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"CommunityGraphPlot", "[", 
                    RowBox[{"graph", ",", 
                    RowBox[{"VertexSize", "\[Rule]", 
                    RowBox[{".02", " ", 
                    SuperscriptBox["n", 
                    RowBox[{"4", "/", "5"}]]}]}], ",", 
                    RowBox[{"CommunityBoundaryStyle", "\[Rule]", "None"}], 
                    ",", 
                    RowBox[{"VertexStyle", "\[Rule]", 
                    RowBox[{"MapIndexed", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{"#1", "\[Equal]", "3"}], ",", "Nothing", ",", 
                    RowBox[{
                    RowBox[{"First", "@", "#2"}], "\[Rule]", 
                    RowBox[{"gColors", "[", "#1", "]"}]}]}], "]"}], "&"}], 
                    ",", 
                    RowBox[{"courseOfEpidemics", "[", 
                    RowBox[{"[", 
                    RowBox[{"Min", "[", 
                    RowBox[{"t", ",", 
                    RowBox[{"Length", "@", "courseOfEpidemics"}]}], "]"}], 
                    "]"}], "]"}]}], "]"}]}]}], "]"}], ",", 
                    RowBox[{"CommunityGraphPlot", "[", 
                    RowBox[{"graph", ",", 
                    RowBox[{"CommunityBoundaryStyle", "\[Rule]", "None"}], 
                    ",", 
                    RowBox[{"VertexStyle", "\[Rule]", 
                    RowBox[{"MapIndexed", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{"#1", "\[Equal]", "3"}], ",", "Nothing", ",", 
                    RowBox[{
                    RowBox[{"First", "@", "#2"}], "\[Rule]", 
                    RowBox[{"gColors", "[", "#1", "]"}]}]}], "]"}], "&"}], 
                    ",", 
                    RowBox[{"courseOfEpidemics", "[", 
                    RowBox[{"[", 
                    RowBox[{"Min", "[", 
                    RowBox[{"t", ",", 
                    RowBox[{"Length", "@", "courseOfEpidemics"}]}], "]"}], 
                    "]"}], "]"}]}], "]"}]}]}], "]"}]}], "]"}], ",", 
                    RowBox[{"Graph", "[", 
                    RowBox[{"graph", ",", 
                    RowBox[{"VertexStyle", "\[Rule]", 
                    RowBox[{"MapIndexed", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{"#1", "\[Equal]", "3"}], ",", "Nothing", ",", 
                    RowBox[{
                    RowBox[{"First", "@", "#2"}], "\[Rule]", 
                    RowBox[{"gColors", "[", "#1", "]"}]}]}], "]"}], "&"}], 
                    ",", 
                    RowBox[{"courseOfEpidemics", "[", 
                    RowBox[{"[", 
                    RowBox[{"Min", "[", 
                    RowBox[{"t", ",", 
                    RowBox[{"Length", "@", "courseOfEpidemics"}]}], "]"}], 
                    "]"}], "]"}]}], "]"}]}]}], "]"}]}], "]"}], 
                    "\[IndentingNewLine]", ",", 
                    RowBox[{"TrackedSymbols", "\[RuleDelayed]", 
                    RowBox[{"{", 
                    RowBox[{
                    "graph", ",", "courseOfEpidemics", ",", "t", ",", 
                    "gColors", ",", "CommunityQ"}], "}"}]}]}], "]"}], ",", 
                   RowBox[{"SynchronousUpdating", "\[Rule]", "Sync"}]}], 
                  "]"}], ",", "\[IndentingNewLine]", 
                 RowBox[{"Placed", "[", 
                  RowBox[{
                   RowBox[{"Dynamic", "[", 
                    RowBox[{"SwatchLegend", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{"merge2", ",", "mergeRDcolor", ",", "Identity"}], 
                    "]"}], "@", 
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{"merge", ",", "mergeDIcolor", ",", "Identity"}], 
                    "]"}], "@", 
                    RowBox[{"Values", "[", "colors", "]"}]}]}], ",", 
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{"merge2", ",", "mergeRDtext", ",", "Identity"}], 
                    "]"}], "@", 
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{"merge", ",", "mergeDItext", ",", "Identity"}], 
                    "]"}], "@", 
                    RowBox[{"Values", "[", "groupAssoc", "]"}]}]}], ",", 
                    RowBox[{"LegendMarkers", "\[Rule]", "\"\<Bubble\>\""}], 
                    ",", 
                    RowBox[{"LegendMarkerSize", "\[Rule]", "15"}], ",", 
                    RowBox[{"LegendLayout", "\[Rule]", "\"\<Row\>\""}], ",", 
                    RowBox[{"LabelStyle", "\[Rule]", 
                    RowBox[{"{", 
                    RowBox[{"FontSize", "\[Rule]", "14"}], "}"}]}]}], 
                    RowBox[{"(*", 
                    RowBox[{",", 
                    RowBox[{"BaseStyle", "\[Rule]", 
                    RowBox[{"EdgeForm", "[", "]"}]}]}], "*)"}], "]"}], "]"}], 
                   ",", "Bottom"}], "]"}]}], "]"}], "\[IndentingNewLine]", 
               ",", 
               RowBox[{"Labeled", "[", 
                RowBox[{
                 RowBox[{"Dynamic", "[", 
                  RowBox[{"Refresh", "[", 
                   RowBox[{
                    RowBox[{"StatPlot", "[", 
                    RowBox[{"stats", ",", 
                    RowBox[{"Dynamic", "@", "t"}], ",", "tmax", ",", 
                    RowBox[{"Sort", "[", "groups", "]"}], ",", 
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Length", "[", "locks", "]"}], ">", "0"}], ",", 
                    RowBox[{"locks", "[", 
                    RowBox[{"[", 
                    RowBox[{"All", ",", 
                    RowBox[{"{", 
                    RowBox[{"2", ",", 
                    RowBox[{"-", "1"}], ",", "1"}], "}"}]}], "]"}], "]"}], 
                    ",", "locks"}], "]"}], ",", "merge", ",", "merge2"}], 
                    "]"}], ",", 
                    RowBox[{"TrackedSymbols", "\[RuleDelayed]", 
                    RowBox[{"{", 
                    RowBox[{
                    "stats", ",", "locks", ",", "groups", ",", "merge", ",", 
                    "merge2"}], "}"}]}]}], "]"}], 
                  RowBox[{"(*", 
                   RowBox[{",", 
                    RowBox[{"SynchronousUpdating", "\[Rule]", "Sync"}]}], 
                   "*)"}], "]"}], ",", 
                 RowBox[{"{", "\"\<time\>\"", "}"}], ",", 
                 RowBox[{"{", "Bottom", "}"}], ",", 
                 RowBox[{"ImageMargins", "\[Rule]", "0"}], ",", 
                 RowBox[{"FrameMargins", "\[Rule]", "0"}], ",", 
                 RowBox[{"Spacings", "\[Rule]", 
                  RowBox[{"{", 
                   RowBox[{"0", ",", "1"}], "}"}]}], ",", 
                 RowBox[{"LabelStyle", "\[Rule]", 
                  RowBox[{"Directive", "[", 
                   RowBox[{
                    RowBox[{"FontFamily", "\[Rule]", "\"\<Helvetica\>\""}], 
                    ",", 
                    RowBox[{"FontSize", "\[Rule]", "16"}]}], "]"}]}]}], 
                "]"}]}], "\[IndentingNewLine]", "}"}], "]"}]}], 
           "\[IndentingNewLine]", "}"}], ",", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"Panel", "@", 
             RowBox[{"Animator", "[", 
              RowBox[{
               RowBox[{"Dynamic", "[", "t", "]"}], ",", 
               RowBox[{"{", 
                RowBox[{"1", ",", 
                 RowBox[{"Dynamic", "@", "tmax"}], ",", "1"}], "}"}], ",", 
               "animParams"}], "]"}]}], ",", "SpanFromLeft"}], "}"}]}], "}"}],
         ",", 
        RowBox[{"Editable", "\[Rule]", "False"}]}], "]"}]}]}], ",", 
    RowBox[{"TrackedSymbols", "\[RuleDelayed]", 
     RowBox[{"{", "}"}]}], ",", 
    RowBox[{"SaveDefinitions", "\[Rule]", "True"}], ",", 
    RowBox[{"Initialization", "\[RuleDelayed]", 
     RowBox[{"(", "\[IndentingNewLine]", 
      RowBox[{"(*", 
       RowBox[{
       "List", " ", "of", " ", "every", " ", "nodes", " ", "neighbour", " ", 
        "list"}], "*)"}], "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"neighboursOfVerticesList", ":=", 
        RowBox[{
         RowBox[{"Table", "[", 
          RowBox[{
           RowBox[{"Complement", "[", 
            RowBox[{
             RowBox[{
              RowBox[{"NeighborhoodGraph", "[", 
               RowBox[{"#", ",", "node"}], "]"}], "//", "VertexList"}], ",", 
             RowBox[{"{", "node", "}"}]}], "]"}], ",", 
           RowBox[{"{", 
            RowBox[{"node", ",", 
             RowBox[{"#", "//", "VertexList"}]}], "}"}]}], "]"}], "&"}]}], 
       ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{"Largest", " ", "subgraph", " ", "of", " ", "given"}], "*)"}],
        "\[IndentingNewLine]", 
       RowBox[{"largestSubgraph", ":=", 
        RowBox[{
         RowBox[{"Subgraph", "[", 
          RowBox[{"#", ",", 
           RowBox[{"First", "[", 
            RowBox[{"ConnectedComponents", "[", "#", "]"}], "]"}]}], "]"}], 
         "&"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
        "Creates", " ", "random", " ", "links", " ", "between", " ", 
         "nodes"}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{"gridBasedSW", ":=", 
        RowBox[{
         RowBox[{"Block", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{
             RowBox[{"base", " ", "=", "#"}], ",", "temp", ",", "length", ",",
              "drawPool"}], "}"}], ",", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"temp", " ", "=", " ", 
             RowBox[{"base", "//", "EdgeList"}]}], ";", "\[IndentingNewLine]", 
            RowBox[{"length", "=", 
             RowBox[{"Length", "[", 
              RowBox[{"base", "//", "VertexList"}], "]"}]}], ";", 
            "\[IndentingNewLine]", 
            RowBox[{"Do", "[", 
             RowBox[{"(*", 
              RowBox[{
               RowBox[{
               "for", " ", "each", " ", "edge", " ", "take", " ", "the", " ", 
                "vertex", " ", 
                RowBox[{"from", " ", "'"}], "the", " ", 
                RowBox[{"left", "'"}]}], "..."}], "*)"}], 
             "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"If", "[", 
               RowBox[{
                RowBox[{
                 RowBox[{"RandomReal", "[", "]"}], "<", "#2"}], ",", 
                RowBox[{"(*", 
                 RowBox[{
                  RowBox[{
                  "...", " ", "with", " ", "probability", " ", "\[Rho]"}], 
                  "..."}], "*)"}], "\[IndentingNewLine]", 
                RowBox[{"(*", 
                 RowBox[{
                  RowBox[{
                  "...", "and", " ", "find", " ", "vertices", " ", "to", " ", 
                   "which", " ", "it", " ", "so", " ", "far", " ", 
                   RowBox[{"wasn", "'"}], "t", " ", "connected"}], "..."}], 
                 "*)"}], "\[IndentingNewLine]", 
                RowBox[{
                 RowBox[{"drawPool", "=", 
                  RowBox[{"Complement", "[", "\[IndentingNewLine]", 
                   RowBox[{
                    RowBox[{"Range", "[", "length", "]"}], ",", 
                    "\[IndentingNewLine]", 
                    RowBox[{"AdjacencyList", "[", 
                    RowBox[{"temp", ",", 
                    RowBox[{"temp", "\[LeftDoubleBracket]", 
                    RowBox[{"edgeInd", ",", "1"}], 
                    "\[RightDoubleBracket]"}]}], "]"}]}], 
                   "\[IndentingNewLine]", 
                   RowBox[{"(*", 
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{"NeighborhoodGraph", "[", 
                    RowBox[{"temp", ",", 
                    RowBox[{"temp", "\[LeftDoubleBracket]", 
                    RowBox[{"edgeInd", ",", "1"}], 
                    "\[RightDoubleBracket]"}]}], "]"}], "//", "VertexList"}], 
                    ")"}], ","}], "*)"}], "\[IndentingNewLine]", 
                   RowBox[{"(*", 
                    RowBox[{"{", 
                    RowBox[{"temp", "\[LeftDoubleBracket]", 
                    RowBox[{"edgeInd", ",", "2"}], "\[RightDoubleBracket]"}], 
                    "}"}], "*)"}], "\[IndentingNewLine]", "]"}]}], ";", 
                 "\[IndentingNewLine]", 
                 RowBox[{"If", "[", 
                  RowBox[{
                   RowBox[{
                    RowBox[{"Length", "[", "drawPool", "]"}], ">", "0"}], ",",
                    "\[IndentingNewLine]", 
                   RowBox[{"(*", 
                    RowBox[{
                    "...", " ", "then", " ", "connect", " ", "it", " ", 
                    "with", " ", "randomly", " ", "choosen", " ", 
                    RowBox[{"one", "."}]}], "*)"}], "\[IndentingNewLine]", 
                   RowBox[{
                    RowBox[{"temp", "\[LeftDoubleBracket]", 
                    RowBox[{"edgeInd", ",", "2"}], "\[RightDoubleBracket]"}], 
                    "=", 
                    RowBox[{"RandomChoice", "[", "drawPool", "]"}]}], 
                   "\[IndentingNewLine]", ",", 
                   RowBox[{"Continue", "[", "]"}]}], "]"}]}], ",", 
                "\[IndentingNewLine]", 
                RowBox[{
                 RowBox[{"Continue", "[", "]"}], ";"}]}], 
               "\[IndentingNewLine]", "]"}], ",", "\[IndentingNewLine]", 
              RowBox[{"{", 
               RowBox[{"edgeInd", ",", 
                RowBox[{
                 RowBox[{"temp", "//", "EdgeList"}], "//", "Length"}]}], 
               "}"}]}], "]"}], ";", "\[IndentingNewLine]", 
            RowBox[{"temp", "//", 
             RowBox[{
              RowBox[{"Graph", "[", 
               RowBox[{
                RowBox[{"Range", "[", "length", "]"}], ",", "#", ",", 
                RowBox[{"GraphLayout", "\[Rule]", "\"\<GridEmbedding\>\""}]}],
                "]"}], "&"}]}]}]}], "\[IndentingNewLine]", "]"}], "&"}]}], 
       ";", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"MakeHoles", "[", 
         RowBox[{"graph_Graph", ",", "count_Integer", ",", 
          RowBox[{"maxSize_Integer", ":", "1"}]}], "]"}], ":=", 
        RowBox[{"Nest", "[", 
         RowBox[{
          RowBox[{
           RowBox[{"Subgraph", "[", 
            RowBox[{"#", ",", 
             RowBox[{"Complement", "[", 
              RowBox[{
               RowBox[{"VertexList", "[", "#", "]"}], ",", 
               RowBox[{"VertexList", "[", 
                RowBox[{"NeighborhoodGraph", "[", 
                 RowBox[{"#", ",", 
                  RowBox[{"RandomSample", "[", 
                   RowBox[{
                    RowBox[{"VertexList", "[", "#", "]"}], ",", "1"}], "]"}], 
                  ",", "maxSize"}], "]"}], "]"}]}], "]"}]}], "]"}], "&"}], 
          ",", "graph", ",", "count"}], "]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
        "used", " ", "to", " ", "keep", " ", "current", " ", "layout", " ", 
         "after", " ", "performing", " ", "function", " ", "fun", " ", "on", 
         " ", 
         RowBox[{"graph", ".", " ", 
          RowBox[{"Note", ":", " ", 
           RowBox[{
           "may", " ", "not", " ", "work", " ", "if", " ", "new", " ", 
            "vertices", " ", "are", " ", "added", " ", "or", " ", "are", " ", 
            "reordered"}]}]}]}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"KeepLayout", "[", 
         RowBox[{"graph_Graph", ",", "fun_", ",", "funParams___"}], "]"}], ":=", 
        RowBox[{"Block", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"coords", ",", "gs"}], "}"}], ",", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"gs", "=", 
            RowBox[{"fun", "[", 
             RowBox[{"graph", ",", "funParams"}], "]"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"coords", "=", 
            RowBox[{
             RowBox[{
              RowBox[{"(", 
               RowBox[{"#", "->", 
                RowBox[{"PropertyValue", "[", 
                 RowBox[{
                  RowBox[{"{", 
                   RowBox[{"graph", ",", "#"}], "}"}], ",", 
                  "VertexCoordinates"}], "]"}]}], ")"}], "&"}], "/@", 
             RowBox[{"VertexList", "[", "gs", "]"}]}]}], ";", 
           RowBox[{"Graph", "[", 
            RowBox[{"gs", ",", 
             RowBox[{"VertexCoordinates", "\[Rule]", "coords"}]}], "]"}]}]}], 
         "]"}]}], ";", "\[IndentingNewLine]", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{"uniformly", " ", "random", " ", "graph"}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"uniform", ":=", 
        RowBox[{
         RowBox[{"RandomGraph", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"#1", ",", 
             RowBox[{"#1", " ", "#3"}]}], "}"}], ",", 
           RowBox[{"GraphLayout", "\[Rule]", "\"\<GridEmbedding\>\""}]}], 
          "]"}], "&"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{"lattice", " ", "2", "D"}], "-", "graph"}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"grid", ":=", 
        RowBox[{
         RowBox[{"GridGraph", "[", 
          RowBox[{"{", 
           RowBox[{
            SqrtBox["#1"], ",", 
            SqrtBox["#1"]}], "}"}], "]"}], "&"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{"Scale", "-", 
         RowBox[{"free", " ", "graph"}]}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{"scaleFree", ":=", 
        RowBox[{
         RowBox[{"RandomGraph", "[", 
          RowBox[{
           RowBox[{"BarabasiAlbertGraphDistribution", "[", 
            RowBox[{"#1", ",", "#3"}], "]"}], ",", 
           RowBox[{"GraphLayout", "\[Rule]", "\"\<GridEmbedding\>\""}]}], 
          "]"}], "&"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{"Small", " ", "World", " ", "graph", " ", 
         RowBox[{"(", 
          RowBox[{"Watts", "-", "Stogratz"}], ")"}]}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"smallWorld", ":=", 
        RowBox[{
         RowBox[{"RandomGraph", "[", 
          RowBox[{
           RowBox[{"WattsStrogatzGraphDistribution", "[", 
            RowBox[{"#1", ",", "#2", ",", "#3"}], "]"}], ",", 
           RowBox[{"GraphLayout", "\[Rule]", "\"\<GridEmbedding\>\""}]}], 
          "]"}], "&"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"smallWorld2", ":=", 
        RowBox[{
         RowBox[{"gridBasedSW", "[", 
          RowBox[{
           RowBox[{"grid", "[", "#1", "]"}], ",", "#2"}], "]"}], "&"}]}], ";",
        "\[IndentingNewLine]", 
       RowBox[{"holedGrid", ":=", 
        RowBox[{
         RowBox[{"KeepLayout", "[", 
          RowBox[{
           RowBox[{"grid", "[", "#1", "]"}], ",", "MakeHoles", ",", "#3", ",", 
           RowBox[{"Max", "[", 
            RowBox[{
             RowBox[{
              RowBox[{"IntegerPart", "[", 
               RowBox[{
                SqrtBox["#1"], "/", "3"}], "]"}], "-", "#3"}], ",", "1"}], 
            "]"}]}], "]"}], "&"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"advGrid", ":=", 
        RowBox[{
         RowBox[{"Block", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"pts", ",", "distances"}], "}"}], ",", 
           RowBox[{
            RowBox[{"pts", "=", 
             RowBox[{"Tuples", "[", 
              RowBox[{
               RowBox[{"Range", "[", 
                SqrtBox["#1"], "]"}], ",", "2"}], "]"}]}], ";", "\n", 
            RowBox[{"distances", "=", 
             RowBox[{"With", "[", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"tr", "=", 
                 RowBox[{"N", "@", 
                  RowBox[{"Transpose", "[", "pts", "]"}]}]}], "}"}], ",", 
               RowBox[{
                RowBox[{"Function", "[", 
                 RowBox[{"point", ",", 
                  RowBox[{"Sqrt", "[", 
                   RowBox[{"Total", "[", 
                    RowBox[{
                    RowBox[{"(", 
                    RowBox[{"point", "-", "tr"}], ")"}], "^", "2"}], "]"}], 
                   "]"}]}], "]"}], "/@", "pts"}]}], "]"}]}], ";", "\n", 
            RowBox[{"SimpleGraph", "[", 
             RowBox[{
              RowBox[{"AdjacencyGraph", "@", 
               RowBox[{"UnitStep", "[", 
                RowBox[{"#3", "-", "distances"}], "]"}]}], ",", 
              RowBox[{"VertexCoordinates", "\[Rule]", "pts"}]}], "]"}]}]}], 
          "]"}], "&"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"regular2k", ":=", 
        RowBox[{
         RowBox[{"CirculantGraph", "[", 
          RowBox[{"#1", ",", 
           RowBox[{"Range", "[", "#3", "]"}], ",", 
           RowBox[{"GraphLayout", "\[Rule]", "\"\<GridEmbedding\>\""}]}], 
          "]"}], "&"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{
         "get", " ", "graph", " ", "without", " ", "self", " ", "loops"}], 
         ",", " ", 
         RowBox[{"then", " ", "largest", " ", "subgraph"}], ",", " ", 
         RowBox[{"then", " ", "reindex"}]}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{"GraphPostprocess", ":=", 
        RowBox[{
         RowBox[{"IndexGraph", "@", 
          RowBox[{"largestSubgraph", "@", 
           RowBox[{"SimpleGraph", "[", "#", "]"}]}]}], "&"}]}], ";", 
       "\[IndentingNewLine]", "\[IndentingNewLine]", "\[IndentingNewLine]", 
       RowBox[{"notAv", "=", "\"\<Not available in this network type\>\""}], 
       ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{"EDIT", " ", "THIS", " ", "TO", " ", "ADD", " ", 
         RowBox[{"GRAPHS", "!"}], " ", "graphs", " ", "and", " ", "params", 
         " ", "each", " ", "graph", " ", "should", " ", "enable", " ", "in", 
         " ", "order", " ", 
         RowBox[{"{", 
          RowBox[{
          "graph", ",", " ", "\[Rho]", ",", " ", "k", ",", " ", 
           "communityPlot", ",", " ", 
           RowBox[{"\[Rho]", " ", "description"}], ",", " ", 
           RowBox[{"k", " ", "description"}], ",", " ", 
           RowBox[{"graph", " ", "type", " ", "description"}]}], "}"}]}], 
        "*)"}], "\n", 
       RowBox[{"graphsInfo", "=", 
        RowBox[{"<|", 
         RowBox[{
          RowBox[{"\"\<Grid\>\"", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "grid", ",", "False", ",", "False", ",", "False", ",", "notAv", 
             ",", "notAv", ",", 
             "\"\<Lattice network of edge \!\(\*SqrtBox[\(n\)]\).\\nSee \
GridGraph in Mathematica.\>\""}], "}"}]}], ",", 
          RowBox[{"\"\<Scale-Free\>\"", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "scaleFree", ",", "False", ",", "True", ",", "True", ",", "notAv",
              ",", "\"\<Influences how many edges each new vertex will have \
during network construction. \>\"", ",", 
             "\"\<Random network built on top of 3-vertex cycle graph.\\nSee \
BarabasiAlbertGraphDistribution in Mathematica.\>\""}], "}"}]}], ",", 
          RowBox[{"\"\<Small-World (WS)\>\"", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "smallWorld", ",", "True", ",", "True", ",", "True", ",", 
             "\"\<Probability of edge rewiring during network construction. \
Makes possibility of long range connections.\>\"", ",", 
             "\"\<Half the mean number of target neighbours.\>\"", ",", 
             "\"\<Random network based on 2k\[Dash]regular graph.\\nSee \
WattsStrogatzGraphDistribution in Mathematica.\>\""}], "}"}]}], ",", 
          RowBox[{"\"\<Small-World (KM)\>\"", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "smallWorld2", ",", "True", ",", "False", ",", "True", ",", 
             "\"\<Probability of changing the edges that connect vertices \
during construction.\>\"", ",", "notAv", ",", 
             "\"\<Random network based on grid graph.\\nSee gridBasedSW \
function definition.\>\""}], "}"}]}], ",", 
          RowBox[{"\"\<Holed Grid\>\"", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "holedGrid", ",", "False", ",", "True", ",", "False", ",", 
             "notAv", ",", 
             "\"\<Number of ruby-shaped holes (disk in manhattan-like metric) \
in the Grid Graph. Their size is automatically adjusted to their count.\>\"", 
             ",", "\"\<Random network based on grid graph with some vertices \
removed.\\nSee holedGrid function definition.\>\""}], "}"}]}], ",", 
          RowBox[{"\"\<Random\>\"", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "uniform", ",", "False", ",", "True", ",", "True", ",", "notAv", 
             ",", "\"\<Mean number of edges per vertex, before discarding \
isolated nodes.\>\"", ",", 
             "\"\<Random network.\\nSee RandomGraph in Mathematica.\>\""}], 
            "}"}]}], ",", 
          RowBox[{"\"\<k-Grid\>\"", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "advGrid", ",", "False", ",", "True", ",", "False", ",", "notAv", 
             ",", "\"\<Connect all neighbours up to distance k.\>\"", ",", 
             "\"\<Lattice network with k nearest neighbours.\\nSee advGrid \
function definition.\>\""}], "}"}]}], ",", 
          RowBox[{"\"\<2k-regular\>\"", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "regular2k", ",", "False", ",", "True", ",", "False", ",", 
             "notAv", ",", "\"\<Connect all neighbours up to distance k.\>\"",
              ",", "\"\<Circular network with k nearest neighbours.\\nSee \
CirculantGraph in Mathematica.\>\""}], "}"}]}]}], "|>"}]}], ";", 
       "\[IndentingNewLine]", "\[IndentingNewLine]", 
       RowBox[{"graphs", "=", 
        RowBox[{"AssociationThread", "[", 
         RowBox[{
          RowBox[{"Keys", "[", "graphsInfo", "]"}], ",", 
          RowBox[{"First", "/@", 
           RowBox[{"Values", "[", "graphsInfo", "]"}]}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"rhoEnabled", "=", 
        RowBox[{"AssociationThread", "[", 
         RowBox[{
          RowBox[{"Keys", "[", "graphsInfo", "]"}], ",", 
          RowBox[{
           RowBox[{
            RowBox[{"#", "[", 
             RowBox[{"[", "2", "]"}], "]"}], "&"}], "/@", 
           RowBox[{"Values", "[", "graphsInfo", "]"}]}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"kEnabled", "=", 
        RowBox[{"AssociationThread", "[", 
         RowBox[{
          RowBox[{"Keys", "[", "graphsInfo", "]"}], ",", 
          RowBox[{
           RowBox[{
            RowBox[{"#", "[", 
             RowBox[{"[", "3", "]"}], "]"}], "&"}], "/@", 
           RowBox[{"Values", "[", "graphsInfo", "]"}]}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"commEnabled", "=", 
        RowBox[{"AssociationThread", "[", 
         RowBox[{
          RowBox[{"Keys", "[", "graphsInfo", "]"}], ",", 
          RowBox[{
           RowBox[{
            RowBox[{"#", "[", 
             RowBox[{"[", "4", "]"}], "]"}], "&"}], "/@", 
           RowBox[{"Values", "[", "graphsInfo", "]"}]}]}], "]"}]}], ";", "\n",
        "\[IndentingNewLine]", 
       RowBox[{"\[Rho]Tooltip", "=", 
        RowBox[{"AssociationThread", "[", 
         RowBox[{
          RowBox[{"Keys", "[", "graphsInfo", "]"}], ",", 
          RowBox[{
           RowBox[{
            RowBox[{"#", "[", 
             RowBox[{"[", "5", "]"}], "]"}], "&"}], "/@", 
           RowBox[{"Values", "[", "graphsInfo", "]"}]}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"kTooltip", "=", 
        RowBox[{"AssociationThread", "[", 
         RowBox[{
          RowBox[{"Keys", "[", "graphsInfo", "]"}], ",", 
          RowBox[{
           RowBox[{
            RowBox[{"#", "[", 
             RowBox[{"[", "6", "]"}], "]"}], "&"}], "/@", 
           RowBox[{"Values", "[", "graphsInfo", "]"}]}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"graphTooltip", "=", 
        RowBox[{"AssociationThread", "[", 
         RowBox[{
          RowBox[{"Keys", "[", "graphsInfo", "]"}], ",", 
          RowBox[{
           RowBox[{
            RowBox[{"#", "[", 
             RowBox[{"[", "7", "]"}], "]"}], "&"}], "/@", 
           RowBox[{"Values", "[", "graphsInfo", "]"}]}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", "\[IndentingNewLine]", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{
          RowBox[{
          "To", " ", "implement", " ", "a", " ", "new", " ", "lockdown", " ", 
           "strategy", " ", "follow", " ", "the", " ", "template", " ", 
           "below", "\[IndentingNewLine]", "history", " ", "should", " ", 
           "contain", " ", "a", " ", "list", " ", "of", " ", 
           RowBox[{"{", 
            RowBox[{"step", ",", "val", ",", "active"}], "}"}], " ", 
           RowBox[{"where", ":"}]}], ",", "\[IndentingNewLine]", 
          RowBox[{"step", ":", " ", 
           RowBox[{"is", " ", "the", " ", "integer", " ", "passed"}]}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"val", ":", " ", 
           RowBox[{"the", " ", "result", " ", "of", " ", "Fun"}]}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"active", ":", " ", 
           RowBox[{
           "true", " ", "if", " ", "threshold", " ", "is", " ", 
            "surpased"}]}], ",", "\[IndentingNewLine]", 
          RowBox[{
          "Of", " ", "course", " ", "you", " ", "can", " ", "define", " ", 
           "additional", " ", "keys", " ", "if", " ", "you", " ", "like"}], 
          ",", " ", 
          RowBox[{
           RowBox[{"as", " ", "long", " ", "as", " ", "this", " ", 
            RowBox[{"doesn", "'"}], "t", " ", "break"}], " ", ";"}]}], ")"}], 
        "\[IndentingNewLine]", "*)"}], "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{"lockdownStrategyTemplate", "=", 
          RowBox[{"<|", 
           RowBox[{
            RowBox[{"Fun", "\[Rule]", 
             RowBox[{"Fun", "[", 
              RowBox[{"currentState", ",", "history", ",", "size"}], "]"}]}], 
            ",", 
            RowBox[{"threshold", "\[Rule]", "thresholdValue"}], ",", 
            RowBox[{"history", "\[Rule]", 
             RowBox[{"{", "}"}]}]}], "|>"}]}], ";"}], "*)"}], 
       "\[IndentingNewLine]", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{
          RowBox[{
          "returns", " ", "an", " ", "updated", " ", 
           "lockdownStrategyObject"}], " ", "-", " ", 
          RowBox[{
          "this", " ", "function", " ", "will", " ", "not", " ", "be", " ", 
           "used"}]}], ",", " ", 
         RowBox[{
         "the", " ", "body", " ", "is", " ", "embedded", " ", "in", " ", 
          "simulation", " ", 
          RowBox[{"(", 
           RowBox[{"so", " ", "we", " ", "get", " ", "less", " ", "calls"}], 
           ")"}]}]}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{
          RowBox[{"ApplyLockdownStrategy", "[", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"step_", ",", "list_", ",", "size_"}], "}"}], ",", 
            "lockdownStrategy_"}], "]"}], ":=", 
          RowBox[{"Block", "[", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"ls", ",", "val"}], "}"}], ",", "\[IndentingNewLine]", 
            RowBox[{
             RowBox[{"ls", "=", "lockdownStrategy"}], ";", 
             "\[IndentingNewLine]", 
             RowBox[{"val", "=", 
              RowBox[{
               RowBox[{"lockdownStrategy", "[", "Fun", "]"}], "[", 
               RowBox[{"list", ",", 
                RowBox[{"ls", "[", "history", "]"}], ",", "size"}], "]"}]}], 
             ";", "\[IndentingNewLine]", 
             RowBox[{"AppendTo", "[", 
              RowBox[{
               RowBox[{"ls", "[", "history", "]"}], ",", 
               RowBox[{"{", 
                RowBox[{"step", ",", "val", ",", 
                 RowBox[{"val", ">", 
                  RowBox[{"ls", "[", "threshold", "]"}]}]}], "}"}]}], "]"}], 
             ";", "\[IndentingNewLine]", "ls"}]}], "\[IndentingNewLine]", 
           "]"}]}], ";"}], "*)"}], "\[IndentingNewLine]", 
       "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
        "This", " ", "strategy", " ", "simply", " ", "counts", " ", 
         "detected"}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{"lsDetCount", "=", 
        RowBox[{"<|", 
         RowBox[{
          RowBox[{"Fun", "\[Rule]", 
           RowBox[{"(", 
            RowBox[{
             RowBox[{
              RowBox[{"Count", "[", 
               RowBox[{"#1", ",", "2"}], "]"}], "/", "#3"}], "&"}], ")"}]}], 
          ",", 
          RowBox[{"threshold", "\[Rule]", "0.01"}], ",", 
          RowBox[{"history", "\[Rule]", 
           RowBox[{"{", "}"}]}]}], "|>"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
        "Checks", " ", "the", " ", "normalized", " ", "change", " ", "in", 
         " ", "detected", " ", "from", " ", "last", " ", "step", " ", "and", 
         " ", "applies", " ", "lockdown", " ", "if", " ", "the", " ", 
         "normalized", " ", "change", " ", "has", " ", "increased", " ", 
         "more", " ", "than", " ", "threshold"}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"lsDetChangeSmall", "=", 
        RowBox[{"<|", 
         RowBox[{
          RowBox[{"Fun", "\[Rule]", 
           RowBox[{"(", 
            RowBox[{
             RowBox[{"If", "[", 
              RowBox[{
               RowBox[{
                RowBox[{"Length", "[", "#2", "]"}], ">", "0"}], ",", 
               RowBox[{
                FractionBox[
                 RowBox[{"Count", "[", 
                  RowBox[{"#1", ",", "2"}], "]"}], "#3"], "-", 
                RowBox[{"#2", "[", 
                 RowBox[{"[", 
                  RowBox[{
                   RowBox[{"-", "1"}], ",", "2"}], "]"}], "]"}]}], ",", 
               FractionBox[
                RowBox[{"Count", "[", 
                 RowBox[{"#1", ",", "2"}], "]"}], "#3"]}], "]"}], "&"}], 
            ")"}]}], ",", 
          RowBox[{"threshold", "\[Rule]", "0.01"}], ",", 
          RowBox[{"history", "\[Rule]", 
           RowBox[{"{", "}"}]}]}], "|>"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"lsDetChangeLarge", "=", 
        RowBox[{"<|", 
         RowBox[{
          RowBox[{"Fun", "\[Rule]", 
           RowBox[{"(", 
            RowBox[{
             RowBox[{"If", "[", 
              RowBox[{
               RowBox[{
                RowBox[{"Length", "[", "#2", "]"}], ">", "0"}], ",", 
               RowBox[{
                FractionBox[
                 RowBox[{"Count", "[", 
                  RowBox[{"#1", ",", "2"}], "]"}], "#3"], "-", 
                RowBox[{"#2", "[", 
                 RowBox[{"[", 
                  RowBox[{
                   RowBox[{"-", "1"}], ",", "2"}], "]"}], "]"}]}], ",", 
               FractionBox[
                RowBox[{"Count", "[", 
                 RowBox[{"#1", ",", "2"}], "]"}], "#3"]}], "]"}], "&"}], 
            ")"}]}], ",", 
          RowBox[{"threshold", "\[Rule]", "0.1"}], ",", 
          RowBox[{"history", "\[Rule]", 
           RowBox[{"{", "}"}]}]}], "|>"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{"Association", "@", 
          RowBox[{"Table", "[", 
           RowBox[{
            RowBox[{
             RowBox[{"\"\<At \>\"", "<>", 
              RowBox[{"ToString", "[", "i", "]"}], "<>", 
              "\"\<% detected\>\""}], "\[Rule]", 
             RowBox[{"<|", 
              RowBox[{
               RowBox[{"Fun", "\[Rule]", 
                RowBox[{"(", 
                 RowBox[{
                  RowBox[{
                   RowBox[{"Count", "[", 
                    RowBox[{"#1", ",", "2"}], "]"}], "/", "#3"}], "&"}], 
                 ")"}]}], ",", 
               RowBox[{"threshold", "\[Rule]", 
                RowBox[{"i", "/", "100"}]}], ",", 
               RowBox[{"history", "\[Rule]", 
                RowBox[{"{", "}"}]}]}], "|>"}]}], ",", 
            RowBox[{"{", 
             RowBox[{"i", ",", 
              RowBox[{"{", 
               RowBox[{"1", ",", "2", ",", "5", ",", "10", ",", "15"}], 
               "}"}]}], "}"}]}], "]"}]}], ";"}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{
         "EDIT", " ", "THIS", " ", "TO", " ", "ADD", " ", "LOCKDOWN", " ", 
          RowBox[{"STRATEGIES", "!"}], " ", "name"}], "\[Rule]", " ", 
         RowBox[{"lockdownStrategy", ".", " ", 
          RowBox[{"Note", ":", " ", 
           RowBox[{
           "functions", " ", "need", " ", "to", " ", "be", " ", "surronded", 
            " ", "by", " ", "normal", " ", "brackets"}]}]}]}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"lsStrategies", "=", 
        RowBox[{"<|", 
         RowBox[{
          RowBox[{"\"\<At 1% detected\>\"", "\[Rule]", 
           RowBox[{"\[LeftAssociation]", 
            RowBox[{
             RowBox[{"Fun", "\[Rule]", 
              RowBox[{"(", 
               RowBox[{
                FractionBox[
                 RowBox[{"Count", "[", 
                  RowBox[{"#1", ",", "2"}], "]"}], "#3"], "&"}], ")"}]}], ",", 
             RowBox[{"threshold", "\[Rule]", 
              FractionBox["1", "100"]}], ",", 
             RowBox[{"history", "\[Rule]", 
              RowBox[{"{", "}"}]}]}], "\[RightAssociation]"}]}], ",", 
          RowBox[{"\"\<At 2% detected\>\"", "\[Rule]", 
           RowBox[{"\[LeftAssociation]", 
            RowBox[{
             RowBox[{"Fun", "\[Rule]", 
              RowBox[{"(", 
               RowBox[{
                FractionBox[
                 RowBox[{"Count", "[", 
                  RowBox[{"#1", ",", "2"}], "]"}], "#3"], "&"}], ")"}]}], ",", 
             RowBox[{"threshold", "\[Rule]", 
              FractionBox["1", "50"]}], ",", 
             RowBox[{"history", "\[Rule]", 
              RowBox[{"{", "}"}]}]}], "\[RightAssociation]"}]}], ",", 
          RowBox[{"\"\<At 5% detected\>\"", "\[Rule]", 
           RowBox[{"\[LeftAssociation]", 
            RowBox[{
             RowBox[{"Fun", "\[Rule]", 
              RowBox[{"(", 
               RowBox[{
                FractionBox[
                 RowBox[{"Count", "[", 
                  RowBox[{"#1", ",", "2"}], "]"}], "#3"], "&"}], ")"}]}], ",", 
             RowBox[{"threshold", "\[Rule]", 
              FractionBox["1", "20"]}], ",", 
             RowBox[{"history", "\[Rule]", 
              RowBox[{"{", "}"}]}]}], "\[RightAssociation]"}]}], ",", 
          RowBox[{"\"\<At 10% detected\>\"", "\[Rule]", 
           RowBox[{"\[LeftAssociation]", 
            RowBox[{
             RowBox[{"Fun", "\[Rule]", 
              RowBox[{"(", 
               RowBox[{
                FractionBox[
                 RowBox[{"Count", "[", 
                  RowBox[{"#1", ",", "2"}], "]"}], "#3"], "&"}], ")"}]}], ",", 
             RowBox[{"threshold", "\[Rule]", 
              FractionBox["1", "10"]}], ",", 
             RowBox[{"history", "\[Rule]", 
              RowBox[{"{", "}"}]}]}], "\[RightAssociation]"}]}], ",", 
          RowBox[{"\"\<At 15% detected\>\"", "\[Rule]", 
           RowBox[{"\[LeftAssociation]", 
            RowBox[{
             RowBox[{"Fun", "\[Rule]", 
              RowBox[{"(", 
               RowBox[{
                FractionBox[
                 RowBox[{"Count", "[", 
                  RowBox[{"#1", ",", "2"}], "]"}], "#3"], "&"}], ")"}]}], ",", 
             RowBox[{"threshold", "\[Rule]", 
              FractionBox["3", "20"]}], ",", 
             RowBox[{"history", "\[Rule]", 
              RowBox[{"{", "}"}]}]}], "\[RightAssociation]"}]}], ",", 
          RowBox[{"\"\<At 50% detected\>\"", "\[Rule]", 
           RowBox[{"\[LeftAssociation]", 
            RowBox[{
             RowBox[{"Fun", "\[Rule]", 
              RowBox[{"(", 
               RowBox[{
                FractionBox[
                 RowBox[{"Count", "[", 
                  RowBox[{"#1", ",", "2"}], "]"}], "#3"], "&"}], ")"}]}], ",", 
             RowBox[{"threshold", "\[Rule]", 
              RowBox[{"1", "/", "2"}]}], ",", 
             RowBox[{"history", "\[Rule]", 
              RowBox[{"{", "}"}]}]}], "\[RightAssociation]"}]}], ",", 
          RowBox[{
          "\"\<At small change of detected\>\"", "->", "lsDetChangeSmall"}], 
          ",", 
          RowBox[{
          "\"\<At large change of detected\>\"", "->", "lsDetChangeLarge"}]}],
          "|>"}]}], ";", "\[IndentingNewLine]", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{
         "This", " ", "function", " ", "looks", " ", "for", " ", "the", " ", 
          "first", " ", "moment", " ", "when", " ", "to", " ", "activate", 
          " ", "lockdown"}], ",", " ", 
         RowBox[{"strat", " ", "is", " ", "a", " ", "lockdownStrategy"}]}], 
        "*)"}], "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"FirstLockdownStep", "[", 
         RowBox[{"strat_", ",", "courseOfEpidemics_", ",", "size_"}], "]"}], ":=", 
        RowBox[{"Block", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"history", ",", 
            RowBox[{"lss", "=", "strat"}], ",", 
            RowBox[{"lockActive", "=", "False"}], ",", "val", ",", 
            RowBox[{"j", "=", "0"}]}], "}"}], ",", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"While", "[", 
            RowBox[{
             RowBox[{
              RowBox[{"!", "lockActive"}], "&&", 
              RowBox[{"j", "<", 
               RowBox[{"Length", "[", "courseOfEpidemics", "]"}]}]}], ",", 
             "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"j", "++"}], ";", "\[IndentingNewLine]", 
              RowBox[{"val", "=", 
               RowBox[{
                RowBox[{"lss", "[", "Fun", "]"}], "[", 
                RowBox[{
                 RowBox[{"courseOfEpidemics", "[", 
                  RowBox[{"[", "j", "]"}], "]"}], ",", 
                 RowBox[{"lss", "[", "history", "]"}], ",", "size"}], "]"}]}],
               ";", "\[IndentingNewLine]", 
              RowBox[{"lockActive", "=", 
               RowBox[{"val", ">", 
                RowBox[{"lss", "[", "threshold", "]"}]}]}], ";", 
              "\[IndentingNewLine]", 
              RowBox[{"AppendTo", "[", 
               RowBox[{
                RowBox[{"lss", "[", "history", "]"}], ",", 
                RowBox[{"{", 
                 RowBox[{"j", ",", "val", ",", "lockActive"}], "}"}]}], "]"}],
               ";"}]}], "\[IndentingNewLine]", "]"}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"{", 
            RowBox[{"j", ",", 
             RowBox[{"courseOfEpidemics", "[", 
              RowBox[{"[", "j", "]"}], "]"}]}], "}"}]}]}], 
         "\[IndentingNewLine]", "]"}]}], ";", "\[IndentingNewLine]", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"simulation", "[", 
         RowBox[{
         "net_Graph", ",", "initialList_List", ",", "\[Lambda]_", ",", "g_", 
          ",", "d_", ",", "o_", ",", 
          RowBox[{"detCanInfect_", ":", "True"}], ",", 
          RowBox[{"lockStrategy_", ":", "None"}], ",", 
          RowBox[{"tmax_", ":", "200"}]}], "]"}], ":=", 
        RowBox[{"Block", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"networks", "=", "net"}], ",", "sizes", ",", "neighbours",
             ",", "det", ",", "inf", ",", "cases", ",", "tcourse", ",", 
            "EndCondition", ",", "UpdateConditions", ",", 
            RowBox[{"lss", "=", "lockStrategy"}], ",", "tmp", ",", "val", ",", 
            RowBox[{"lockActive", "=", "False"}]}], "}"}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"sizes", "=", 
            RowBox[{"networks", "//", "VertexCount"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"neighbours", "=", 
            RowBox[{"networks", "//", "neighboursOfVerticesList"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"EndCondition", ":=", 
            RowBox[{
             RowBox[{"inf", "===", "0"}], "&&", 
             RowBox[{"det", "===", "0"}]}]}], ";", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"UpdateConditions", "[", "list_List", "]"}], ":=", 
            RowBox[{"(", 
             RowBox[{
              RowBox[{"inf", "=", 
               RowBox[{"Count", "[", 
                RowBox[{"list", ",", "1"}], "]"}]}], ";", 
              RowBox[{"det", "=", 
               RowBox[{"Count", "[", 
                RowBox[{"list", ",", "2"}], "]"}]}], ";", "list"}], ")"}]}], 
           ";", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{"cases", "[", 
             RowBox[{"i_Integer", ",", "j_Integer"}], "]"}], ":=", 
            RowBox[{
             RowBox[{"cases", "[", 
              RowBox[{"i", ",", "j"}], "]"}], "=", "\[IndentingNewLine]", 
             RowBox[{"Switch", "[", 
              RowBox[{
               RowBox[{"cases", "[", 
                RowBox[{
                 RowBox[{"i", "-", "1"}], ",", "j"}], "]"}], ",", 
               "\[IndentingNewLine]", 
               RowBox[{"(*", "Infected", "*)"}], "\[IndentingNewLine]", "1", 
               ",", 
               RowBox[{"RandomChoice", "[", 
                RowBox[{
                 RowBox[{"{", 
                  RowBox[{"g", ",", "d", ",", 
                   RowBox[{"1", "-", "g", "-", "d"}]}], "}"}], "\[Rule]", 
                 RowBox[{"{", 
                  RowBox[{"4", ",", "5", ",", 
                   RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"RandomReal", "[", "]"}], "<", "o"}], ",", "2", 
                    ",", "1"}], "]"}]}], "}"}]}], "]"}], ",", 
               RowBox[{"(*", 
                RowBox[{"recover", ",", 
                 RowBox[{
                 "die", " ", "if", " ", "not", " ", "detected", " ", "or", 
                  " ", "just", " ", "still", " ", "infected"}]}], "*)"}], 
               "\[IndentingNewLine]", 
               RowBox[{"(*", "Detected", "*)"}], "\[IndentingNewLine]", "2", 
               ",", 
               RowBox[{"RandomChoice", "[", 
                RowBox[{
                 RowBox[{"{", 
                  RowBox[{"g", ",", "d", ",", 
                   RowBox[{"1", "-", "g", "-", "d"}]}], "}"}], "\[Rule]", 
                 RowBox[{"{", 
                  RowBox[{"4", ",", "5", ",", "2"}], "}"}]}], "]"}], ",", 
               RowBox[{"(*", 
                RowBox[{"recover", ",", 
                 RowBox[{"die", " ", "or", " ", "stay", " ", "detected"}]}], 
                "*)"}], "\[IndentingNewLine]", 
               RowBox[{"(*", "Susceptible", "*)"}], "\[IndentingNewLine]", 
               "3", ",", 
               RowBox[{"If", "[", 
                RowBox[{
                 RowBox[{
                  RowBox[{"RandomReal", "[", "]"}], ">", 
                  RowBox[{"Product", "[", 
                   RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"cases", "[", 
                    RowBox[{
                    RowBox[{"i", "-", "1"}], ",", "u"}], "]"}], "<", 
                    RowBox[{"If", "[", 
                    RowBox[{"detCanInfect", ",", "3", ",", "2"}], "]"}]}], 
                    ",", 
                    RowBox[{"1", "-", "\[Lambda]"}], ",", "1"}], "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"u", ",", 
                    RowBox[{"If", "[", 
                    RowBox[{"lockActive", ",", 
                    RowBox[{"{", "}"}], ",", 
                    RowBox[{"neighbours", "[", 
                    RowBox[{"[", "j", "]"}], "]"}]}], "]"}]}], "}"}]}], 
                   "]"}]}], ",", "1", ",", "3"}], "]"}], ",", 
               RowBox[{"(*", 
                RowBox[{
                "become", " ", "infected", " ", "or", " ", "stay", " ", 
                 "sus"}], "*)"}], "\[IndentingNewLine]", 
               RowBox[{"(*", "Recovered", "*)"}], "4", ",", "4", ",", 
               "\[IndentingNewLine]", 
               RowBox[{"(*", "Dead", "*)"}], "5", ",", "5"}], "]"}]}]}], ";", 
           "\[IndentingNewLine]", "\[IndentingNewLine]", 
           RowBox[{"(*", 
            RowBox[{
            "Initially", " ", "everyone", " ", "is", " ", "susceptible"}], 
            "*)"}], "\[IndentingNewLine]", 
           RowBox[{"inf", "=", 
            RowBox[{"Count", "[", 
             RowBox[{"initialList", ",", "1"}], "]"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"det", "=", 
            RowBox[{"Count", "[", 
             RowBox[{"initialList", ",", "2"}], "]"}]}], ";", 
           "\[IndentingNewLine]", 
           RowBox[{"Do", "[", 
            RowBox[{
             RowBox[{
              RowBox[{"cases", "[", 
               RowBox[{"1", ",", "i"}], "]"}], "=", 
              RowBox[{"initialList", "[", 
               RowBox[{"[", "i", "]"}], "]"}]}], ",", 
             RowBox[{"{", 
              RowBox[{"i", ",", "1", ",", 
               RowBox[{"Length", "[", "initialList", "]"}]}], "}"}]}], "]"}], 
           ";", "\[IndentingNewLine]", "\[IndentingNewLine]", 
           RowBox[{"tcourse", "=", 
            RowBox[{"If", "[", 
             RowBox[{
              RowBox[{"lss", "=!=", "None"}], ",", "\[IndentingNewLine]", 
              RowBox[{"(*", 
               RowBox[{"if", " ", "lockdownStrategy", " ", "provided"}], 
               "*)"}], "\[IndentingNewLine]", 
              RowBox[{"Table", "[", "\[IndentingNewLine]", 
               RowBox[{
                RowBox[{
                 RowBox[{"If", "[", 
                  RowBox[{
                  "EndCondition", ",", "Nothing", ",", "\[IndentingNewLine]", 
                   
                   RowBox[{"tmp", "=", 
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Mod", "[", 
                    RowBox[{"i", ",", "10"}], "]"}], "\[Equal]", "0"}], ",", 
                    "UpdateConditions", ",", "Identity"}], "]"}], "@", 
                    RowBox[{"Table", "[", 
                    RowBox[{
                    RowBox[{"cases", "[", 
                    RowBox[{"i", ",", "j"}], "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"j", ",", "sizes"}], "}"}]}], "]"}]}]}]}], "]"}], 
                 ";", "\[IndentingNewLine]", 
                 RowBox[{"val", "=", 
                  RowBox[{
                   RowBox[{"lss", "[", "Fun", "]"}], "[", 
                   RowBox[{"tmp", ",", 
                    RowBox[{"lss", "[", "history", "]"}], ",", "sizes"}], 
                   "]"}]}], ";", 
                 RowBox[{"lockActive", "=", 
                  RowBox[{"val", ">", 
                   RowBox[{"lss", "[", "threshold", "]"}]}]}], ";", 
                 RowBox[{"AppendTo", "[", 
                  RowBox[{
                   RowBox[{"lss", "[", "history", "]"}], ",", 
                   RowBox[{"{", 
                    RowBox[{"i", ",", "val", ",", "lockActive"}], "}"}]}], 
                  "]"}], ";", "\[IndentingNewLine]", "tmp"}], ",", 
                RowBox[{"{", 
                 RowBox[{"i", ",", "tmax"}], "}"}]}], "]"}], ",", 
              "\[IndentingNewLine]", 
              RowBox[{"(*", 
               RowBox[{"no", " ", "lockdownStrategy"}], "*)"}], 
              "\[IndentingNewLine]", 
              RowBox[{"Table", "[", "\[IndentingNewLine]", 
               RowBox[{
                RowBox[{"If", "[", 
                 RowBox[{
                 "EndCondition", ",", "Nothing", ",", "\[IndentingNewLine]", 
                  RowBox[{
                   RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"Mod", "[", 
                    RowBox[{"i", ",", "10"}], "]"}], "\[Equal]", "0"}], ",", 
                    "UpdateConditions", ",", "Identity"}], "]"}], "@", 
                   RowBox[{"Table", "[", 
                    RowBox[{
                    RowBox[{"cases", "[", 
                    RowBox[{"i", ",", "j"}], "]"}], ",", 
                    RowBox[{"{", 
                    RowBox[{"j", ",", "sizes"}], "}"}]}], "]"}]}]}], "]"}], 
                "\[IndentingNewLine]", ",", 
                RowBox[{"{", 
                 RowBox[{"i", ",", "tmax"}], "}"}]}], "]"}]}], 
             "\[IndentingNewLine]", "]"}]}], ";", "\[IndentingNewLine]", 
           RowBox[{
            RowBox[{
             RowBox[{
              RowBox[{"{", "tcourse", "}"}], "//", 
              RowBox[{"Append", "[", "lss", "]"}]}], "//", 
             RowBox[{"Append", "[", "sizes", "]"}]}], "//", 
            RowBox[{"Append", "[", 
             RowBox[{"Length", "[", "tcourse", "]"}], "]"}]}]}]}], 
         "\[IndentingNewLine]", "]"}]}], ";", "\[IndentingNewLine]", 
       "\[IndentingNewLine]", 
       RowBox[{"statify", ":=", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"Count", "[", 
            RowBox[{"#", ",", "1"}], "]"}], ",", 
           RowBox[{"Count", "[", 
            RowBox[{"#", ",", "2"}], "]"}], ",", 
           RowBox[{"Count", "[", 
            RowBox[{"#", ",", "3"}], "]"}], ",", 
           RowBox[{"Count", "[", 
            RowBox[{"#", ",", "4"}], "]"}], ",", 
           RowBox[{"Count", "[", 
            RowBox[{"#", ",", "5"}], "]"}]}], "}"}], "&"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"ticks", "=", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"None", ",", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{"{", 
               RowBox[{"0", ",", "\"\<0%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.1", ",", "\"\<10%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.2", ",", "\"\<20%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.3", ",", "\"\<30%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.4", ",", "\"\<40%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.5", ",", "\"\<50%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.6", ",", "\"\<60%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.7", ",", "\"\<70%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.8", ",", "\"\<80%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"0.9", ",", "\"\<90%\>\""}], "}"}], ",", 
              RowBox[{"{", 
               RowBox[{"1", ",", "\"\<100%\>\""}], "}"}]}], "}"}]}], "}"}], 
          ",", 
          RowBox[{"{", 
           RowBox[{"Automatic", ",", "Automatic"}], "}"}]}], "}"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"StatPlot", "[", 
         RowBox[{"stats_", ",", "i_", ",", "tmax_", ",", "groups_", ",", 
          RowBox[{"lds_", ":", 
           RowBox[{"{", "}"}]}], ",", "merge_", ",", "merge2_"}], "]"}], ":=", 
        RowBox[{"Show", "[", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{"ListLinePlot", "[", 
           RowBox[{
            RowBox[{"(", 
             RowBox[{
              RowBox[{"If", "[", 
               RowBox[{"merge2", ",", "mergeRD", ",", "Identity"}], "]"}], 
              "@", 
              RowBox[{
               RowBox[{"If", "[", 
                RowBox[{"merge", ",", "mergeDI", ",", "Identity"}], "]"}], 
               "@", 
               RowBox[{"(", 
                RowBox[{"stats", "[", 
                 RowBox[{"[", "groups", "]"}], "]"}], ")"}]}]}], ")"}], ",", 
            RowBox[{"PlotStyle", "\[Rule]", 
             RowBox[{"(", 
              RowBox[{
               RowBox[{"If", "[", 
                RowBox[{"merge2", ",", "mergeRDcolor", ",", "Identity"}], 
                "]"}], "@", 
               RowBox[{
                RowBox[{"If", "[", 
                 RowBox[{"merge", ",", "mergeDIcolor", ",", "Identity"}], 
                 "]"}], "@", 
                RowBox[{"(", 
                 RowBox[{
                  RowBox[{"Values", "[", "colors", "]"}], "[", 
                  RowBox[{"[", "groups", "]"}], "]"}], ")"}]}]}], ")"}]}], 
            ",", 
            RowBox[{"PlotRange", "\[Rule]", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"1", ",", "tmax"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"0", ",", "1"}], "}"}]}], "}"}]}], ",", 
            RowBox[{"AspectRatio", "\[Rule]", "0.6"}], " ", ",", 
            RowBox[{"ImageSize", "\[Rule]", 
             RowBox[{"{", 
              RowBox[{"previewSize", ",", 
               RowBox[{"previewSize", " ", "0.6"}]}], "}"}]}], ",", 
            RowBox[{"Epilog", "\[Rule]", 
             RowBox[{"{", 
              RowBox[{"Thick", ",", "Dashed", ",", 
               RowBox[{"Line", "[", 
                RowBox[{"{", 
                 RowBox[{
                  RowBox[{"{", 
                   RowBox[{"i", ",", "0"}], "}"}], ",", 
                  RowBox[{"{", 
                   RowBox[{"i", ",", "1"}], "}"}]}], "}"}], "]"}]}], "}"}]}], 
            ",", 
            RowBox[{"Frame", "\[Rule]", "True"}], ",", 
            RowBox[{"FrameLabel", "\[Rule]", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"{", 
                RowBox[{"None", ",", "None"}], "}"}], ",", 
               RowBox[{"{", 
                RowBox[{"None", ",", "None"}], "}"}]}], "}"}]}], ",", 
            RowBox[{"FrameTicks", "\[Rule]", "ticks"}], ",", 
            RowBox[{"FrameStyle", "\[Rule]", 
             RowBox[{"Directive", "[", 
              RowBox[{"Black", ",", "14"}], "]"}]}]}], "]"}], ",", 
          "\[IndentingNewLine]", 
          RowBox[{"Sequence", "@@", 
           RowBox[{"(", 
            RowBox[{"Table", "[", 
             RowBox[{
              RowBox[{"(", 
               RowBox[{"ListLinePlot", "[", 
                RowBox[{
                 RowBox[{
                  RowBox[{"If", "[", 
                   RowBox[{"merge2", ",", "mergeRD", ",", "Identity"}], "]"}],
                   "@", 
                  RowBox[{
                   RowBox[{"If", "[", 
                    RowBox[{"merge", ",", "mergeDI", ",", "Identity"}], "]"}],
                    "@", 
                   RowBox[{"(", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"lds", "[", 
                    RowBox[{"[", "k", "]"}], "]"}], "[", 
                    RowBox[{"[", "2", "]"}], "]"}], "[", 
                    RowBox[{"[", "groups", "]"}], "]"}], ")"}]}]}], ",", 
                 RowBox[{"DataRange", "\[Rule]", 
                  RowBox[{"{", 
                   RowBox[{
                    RowBox[{
                    RowBox[{"lds", "[", 
                    RowBox[{"[", "k", "]"}], "]"}], "[", 
                    RowBox[{"[", "1", "]"}], "]"}], ",", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"lds", "[", 
                    RowBox[{"[", "k", "]"}], "]"}], "[", 
                    RowBox[{"[", "1", "]"}], "]"}], "+", 
                    RowBox[{"Length", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"lds", "[", 
                    RowBox[{"[", "k", "]"}], "]"}], "[", 
                    RowBox[{"[", "2", "]"}], "]"}], "[", 
                    RowBox[{"[", "1", "]"}], "]"}], "]"}], "-", "1"}]}], 
                   "}"}]}], ",", 
                 RowBox[{"PlotStyle", "\[Rule]", 
                  RowBox[{"(", 
                   RowBox[{
                    RowBox[{
                    RowBox[{"Directive", "[", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"Dotted", ",", "Dashed", ",", "DotDashed"}], 
                    "}"}], "[", 
                    RowBox[{"[", 
                    RowBox[{"Mod", "[", 
                    RowBox[{"k", ",", "2", ",", "1"}], "]"}], "]"}], "]"}], 
                    ",", 
                    RowBox[{"Nest", "[", 
                    RowBox[{"Lighter", ",", "#", ",", "k"}], "]"}]}], "]"}], 
                    "&"}], "/@", 
                    RowBox[{"(", 
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{"merge2", ",", "mergeRDcolor", ",", "Identity"}], 
                    "]"}], "@", 
                    RowBox[{
                    RowBox[{"If", "[", 
                    RowBox[{"merge", ",", "mergeDIcolor", ",", "Identity"}], 
                    "]"}], "@", 
                    RowBox[{
                    RowBox[{"Values", "[", "colors", "]"}], "[", 
                    RowBox[{"[", "groups", "]"}], "]"}]}]}], ")"}]}], ")"}]}],
                  ",", 
                 RowBox[{"PlotLegends", "\[Rule]", 
                  RowBox[{"Placed", "[", 
                   RowBox[{
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{"lds", "[", 
                    RowBox[{"[", "k", "]"}], "]"}], "[", 
                    RowBox[{"[", "3", "]"}], "]"}], "}"}], ",", 
                    RowBox[{"{", 
                    RowBox[{
                    RowBox[{
                    RowBox[{"{", 
                    RowBox[{"Left", ",", "Right"}], "}"}], "[", 
                    RowBox[{"[", 
                    RowBox[{"Mod", "[", 
                    RowBox[{"k", ",", "2", ",", "1"}], "]"}], "]"}], "]"}], 
                    ",", "Top"}], "}"}]}], "]"}]}]}], "]"}], ")"}], ",", 
              RowBox[{"{", 
               RowBox[{"k", ",", "1", ",", 
                RowBox[{"Length", "@", "lds"}]}], "}"}]}], "]"}], ")"}]}]}], 
         "]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"mergeDI", "[", 
         RowBox[{"{", 
          RowBox[{"inf_", ",", "det_", ",", "rest___"}], "}"}], "]"}], ":=", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"inf", "+", "det"}], ",", "rest"}], "}"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"mergeDIcolor", "[", 
         RowBox[{"{", 
          RowBox[{"inf_", ",", "det_", ",", "rest___"}], "}"}], "]"}], ":=", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"Blend", "[", 
           RowBox[{"{", 
            RowBox[{"inf", ",", "det"}], "}"}], "]"}], ",", "rest"}], "}"}]}],
        ";", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"mergeDItext", "[", 
         RowBox[{"{", 
          RowBox[{"inf_", ",", "det_", ",", "rest___"}], "}"}], "]"}], ":=", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"inf", "<>", "\"\<+\>\"", "<>", "det"}], ",", "rest"}], 
         "}"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"mergeRD", "[", 
         RowBox[{"{", 
          RowBox[{"rest___", ",", "rec_", ",", "dead_"}], "}"}], "]"}], ":=", 
        
        RowBox[{"{", 
         RowBox[{"rest", ",", 
          RowBox[{"rec", "+", "dead"}]}], "}"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"mergeRDcolor", "[", 
         RowBox[{"{", 
          RowBox[{"rest___", ",", "rec_", ",", "dead_"}], "}"}], "]"}], ":=", 
        
        RowBox[{"{", 
         RowBox[{"rest", ",", 
          RowBox[{"Blend", "[", 
           RowBox[{"{", 
            RowBox[{"rec", ",", "dead"}], "}"}], "]"}]}], "}"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"mergeRDtext", "[", 
         RowBox[{"{", 
          RowBox[{"rest___", ",", "rec_", ",", "dead_"}], "}"}], "]"}], ":=", 
        
        RowBox[{"{", 
         RowBox[{"rest", ",", 
          RowBox[{"rec", "<>", "\"\<+\>\"", "<>", "dead"}]}], "}"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"PadStats", "[", 
         RowBox[{"list_", ",", "len_"}], "]"}], ":=", 
        RowBox[{"PadRight", "[", 
         RowBox[{"list", ",", "len", ",", 
          RowBox[{"list", "[", 
           RowBox[{"[", 
            RowBox[{"-", "1"}], "]"}], "]"}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"(*", "\[IndentingNewLine]", 
        RowBox[{
         RowBox[{
          RowBox[{"StatPlot", "[", 
           RowBox[{"Sstats_", ",", "Si_", ",", "Stmax_", ",", "Sgroups_", ",", 
            RowBox[{"Slds_", ":", 
             RowBox[{"{", "}"}]}], ",", "Smerge_", ",", "Smerge2_"}], "]"}], ":=", 
          RowBox[{"(", 
           RowBox[{"(*", 
            RowBox[{
             RowBox[{"Print", "[", "Sstats", "]"}], ";"}], "*)"}], 
           "\[IndentingNewLine]", 
           RowBox[{"ListLinePlot", "[", 
            RowBox[{
             RowBox[{"(", 
              RowBox[{
               RowBox[{"If", "[", 
                RowBox[{"Smerge2", ",", "mergeRD", ",", "Identity"}], "]"}], 
               "@", 
               RowBox[{
                RowBox[{"If", "[", 
                 RowBox[{"Smerge", ",", "mergeDI", ",", "Identity"}], "]"}], 
                "@", 
                RowBox[{"(", 
                 RowBox[{"Sstats", "[", 
                  RowBox[{"[", "Sgroups", "]"}], "]"}], ")"}]}]}], ")"}], ",", 
             RowBox[{"PlotStyle", "\[Rule]", 
              RowBox[{"(", 
               RowBox[{
                RowBox[{"If", "[", 
                 RowBox[{"Smerge2", ",", "mergeRDcolor", ",", "Identity"}], 
                 "]"}], "@", 
                RowBox[{
                 RowBox[{"If", "[", 
                  RowBox[{"Smerge", ",", "mergeDIcolor", ",", "Identity"}], 
                  "]"}], "@", 
                 RowBox[{"(", 
                  RowBox[{
                   RowBox[{"Values", "[", "colors", "]"}], "[", 
                   RowBox[{"[", "Sgroups", "]"}], "]"}], ")"}]}]}], ")"}]}], 
             ",", 
             RowBox[{"PlotRange", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{
                RowBox[{"{", 
                 RowBox[{"1", ",", "Stmax"}], "}"}], ",", 
                RowBox[{"{", 
                 RowBox[{"0", ",", "1"}], "}"}]}], "}"}]}], ",", 
             RowBox[{"AspectRatio", "\[Rule]", "0.6"}], " ", ",", 
             RowBox[{"ImageSize", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"previewSize", ",", 
                RowBox[{"previewSize", " ", "0.6"}]}], "}"}]}], ",", 
             RowBox[{"Epilog", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"Thick", ",", "Dashed", ",", 
                RowBox[{"Line", "[", 
                 RowBox[{"{", 
                  RowBox[{
                   RowBox[{"{", 
                    RowBox[{"Si", ",", "0"}], "}"}], ",", 
                   RowBox[{"{", 
                    RowBox[{"Si", ",", "1"}], "}"}]}], "}"}], "]"}]}], 
               "}"}]}], ",", 
             RowBox[{"Frame", "\[Rule]", "True"}], ",", 
             RowBox[{"FrameLabel", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{
                RowBox[{"{", 
                 RowBox[{"None", ",", "None"}], "}"}], ",", 
                RowBox[{"{", 
                 RowBox[{"None", ",", "None"}], "}"}]}], "}"}]}], ",", 
             RowBox[{"FrameTicks", "\[Rule]", "ticks"}], ",", 
             RowBox[{"FrameStyle", "\[Rule]", 
              RowBox[{"Directive", "[", 
               RowBox[{"Black", ",", "14"}], "]"}]}]}], "]"}], ")"}]}], ";"}],
         "*)"}], "\[IndentingNewLine]", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{
        "esential", " ", "parameters", " ", "for", " ", "limiting", "  ", 
         "slow", " ", "performance"}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{"Sync", "=", "False"}], ";", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{
         "whether", " ", "to", " ", "use", " ", "sync", " ", "or", " ", 
          "async", " ", "for", " ", "dynamic", " ", "elements"}], ",", " ", 
         RowBox[{
         "currently", " ", "only", " ", "graph", " ", "displpay", " ", "uses",
           " ", "this", " ", "flag"}]}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{"maxn", "=", 
        SuperscriptBox["30", "2"]}], ";", " ", 
       RowBox[{"(*", 
        RowBox[{"maximal", " ", "population", " ", "to", " ", "choose"}], 
        "*)"}], "\[IndentingNewLine]", 
       RowBox[{"allowed", "=", 
        RowBox[{"Table", "[", 
         RowBox[{
          SuperscriptBox["i", "2"], ",", 
          RowBox[{"{", 
           RowBox[{"i", ",", "4", ",", 
            SqrtBox["maxn"]}], "}"}]}], "]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"previewSize", "=", "500"}], ";", " ", 
       RowBox[{"(*", 
        RowBox[{"size", " ", "of", " ", "the", " ", "plots"}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"hardtmax", "=", "100"}], ";", " ", 
       RowBox[{"(*", 
        RowBox[{"maximal", " ", "time", " ", "of", " ", "simulation"}], 
        "*)"}], "\[IndentingNewLine]", 
       RowBox[{"saveDefs", "=", "True"}], ";", " ", 
       RowBox[{"(*", 
        RowBox[{
         RowBox[{"save", " ", "definitions", " ", "in", " ", "notebook"}], 
         ",", " ", 
         RowBox[{
         "will", " ", "become", " ", "useful", " ", "for", " ", "CDF"}]}], 
        "*)"}], " ", "\[IndentingNewLine]", 
       RowBox[{"SetOptions", "[", 
        RowBox[{"$FrontEndSession", ",", 
         RowBox[{"DynamicEvaluationTimeout", "\[Rule]", "30"}]}], "]"}], ";", 
       " ", 
       RowBox[{"(*", 
        RowBox[{
        "increased", " ", "time", " ", "for", " ", "dynamic", " ", 
         "updates"}], "*)"}], "\[IndentingNewLine]", 
       RowBox[{"framerate", "=", "2"}], ";", " ", 
       RowBox[{"(*", 
        RowBox[{
        "how", " ", "many", " ", "frames", " ", "per", " ", "second", " ", 
         "to", " ", "display", " ", "in", " ", "the", " ", "video"}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"ensembleSize", "=", "10"}], ";", " ", 
       RowBox[{"(*", 
        RowBox[{
        "how", " ", "many", " ", "runs", " ", "to", " ", "perform", " ", 
         "when", " ", "doing", " ", "statistics"}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{"(*", "looks", "*)"}], "\[IndentingNewLine]", 
       RowBox[{"groupAssoc", "=", 
        RowBox[{"<|", 
         RowBox[{
          RowBox[{"1", "->", "\"\<inf\>\""}], ",", 
          RowBox[{"2", "->", "\"\<det\>\""}], ",", 
          RowBox[{"3", "->", "\"\<sus\>\""}], ",", 
          RowBox[{"4", "->", " ", "\"\<rec\>\""}], ",", 
          RowBox[{"5", "->", "\"\<dead\>\""}]}], "|>"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"colors", "=", 
        RowBox[{"<|", 
         RowBox[{
          RowBox[{"1", "\[Rule]", "Red"}], ",", 
          RowBox[{"2", "\[Rule]", 
           RowBox[{"Lighter", "[", "Orange", "]"}]}], ",", 
          RowBox[{"3", "\[Rule]", 
           RowBox[{"Lighter", "[", "Gray", "]"}]}], ",", 
          RowBox[{"4", "\[Rule]", 
           RowBox[{"RGBColor", "[", 
            RowBox[{"0.54", ",", "1.", ",", "0.94"}], "]"}]}], ",", 
          RowBox[{"5", "\[Rule]", "Black"}]}], "|>"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"regularParams", "=", 
        RowBox[{"Sequence", "[", 
         RowBox[{
          RowBox[{"Alignment", "\[Rule]", "Center"}], ",", 
          RowBox[{"ContinuousAction", "\[Rule]", "True"}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"sliderParams", "=", 
        RowBox[{"Sequence", "[", 
         RowBox[{
          RowBox[{"Appearance", "\[Rule]", "\"\<DownArrow\>\""}], ",", 
          "regularParams"}], "]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"animParams", "=", 
        RowBox[{"Sequence", "[", 
         RowBox[{
          RowBox[{"AppearanceElements", "\[Rule]", 
           RowBox[{"{", 
            RowBox[{
            "\"\<ProgressSlider\>\"", ",", "\"\<PlayPauseButton\>\"", ",", 
             "\"\<ResetButton\>\"", ",", "\"\<StepLeftButton\>\"", ",", 
             "\"\<StepRightButton\>\"", ",", "\"\<FasterSlowerButtons\>\""}], 
            "}"}]}], ",", 
          RowBox[{"AnimationRunning", "\[Rule]", "False"}], ",", 
          RowBox[{"AnimationRepetitions", "\[Rule]", "1"}], ",", 
          RowBox[{"DisplayAllSteps", "\[Rule]", "True"}], ",", 
          RowBox[{"(*", 
           RowBox[{
            RowBox[{"ImageMargins", "\[Rule]", "0"}], ","}], "*)"}], 
          RowBox[{"ImageSize", "\[Rule]", "850"}], ",", 
          RowBox[{"DisplayAllSteps", "\[Rule]", "True"}], ",", " ", 
          RowBox[{"Appearance", "\[Rule]", 
           RowBox[{"{", "\"\<Labeled\>\"", "}"}]}]}], "]"}]}], ";", 
       "\[IndentingNewLine]", "\[IndentingNewLine]", 
       RowBox[{"(*", 
        RowBox[{"definitions", " ", "of", " ", "sliders"}], "*)"}], 
       "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"cost", "[", 
         RowBox[{"val_", ",", 
          RowBox[{"{", 
           RowBox[{"min_", ",", "max_", ",", "step_"}], "}"}]}], "]"}], ":=", 
        
        RowBox[{"(", 
         RowBox[{"Min", "[", 
          RowBox[{
           RowBox[{"Max", "[", 
            RowBox[{
             RowBox[{"Round", "[", 
              RowBox[{"val", ",", "step"}], "]"}], ",", "min"}], "]"}], ",", 
           "max"}], "]"}], ")"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"SetAttributes", "[", 
        RowBox[{"sl", ",", "HoldRest"}], "]"}], ";", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"sl", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"ss_", ",", "min_", ",", "max_", ",", 
            RowBox[{"step_", ":", "0.001"}], ",", 
            RowBox[{"enabled_", ":", "True"}]}], "}"}], ",", 
          RowBox[{"post_", ":", "Identity"}]}], "]"}], ":=", 
        "\[IndentingNewLine]", 
        RowBox[{"Row", "[", 
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"Slider", "[", 
            RowBox[{
             RowBox[{"Dynamic", "[", 
              RowBox[{"ss", ",", 
               RowBox[{"{", 
                RowBox[{
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{"ss", "=", "#"}], ")"}], "&"}], ",", 
                 RowBox[{
                  RowBox[{"(", " ", "post", ")"}], "&"}]}], "}"}]}], "]"}], 
             ",", 
             RowBox[{"{", 
              RowBox[{"min", ",", "max", ",", "step"}], "}"}], ",", 
             RowBox[{"Enabled", "\[Rule]", "enabled"}]}], "]"}], ",", 
           "\[IndentingNewLine]", "\"\<       \>\"", ",", 
           "\[IndentingNewLine]", 
           RowBox[{"InputField", "[", 
            RowBox[{
             RowBox[{"Dynamic", "[", 
              RowBox[{
               RowBox[{"If", "[", 
                RowBox[{
                 RowBox[{"IntegerQ", "[", "step", "]"}], ",", 
                 RowBox[{"IntegerPart", "[", "ss", "]"}], ",", " ", 
                 RowBox[{"SetAccuracy", "[", 
                  RowBox[{"ss", ",", "4"}], "]"}]}], "]"}], ",", 
               RowBox[{"{", 
                RowBox[{
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{"ss", "=", "#"}], ")"}], "&"}], ",", 
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{
                    RowBox[{"ss", "=", "#"}], ";", "  ", 
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{"NumericQ", "[", "ss", "]"}], ",", "post"}], 
                    "]"}]}], ")"}], "&"}]}], "}"}]}], "]"}], ",", "Number", 
             ",", 
             RowBox[{"FieldSize", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"4", ",", "1"}], "}"}]}], ",", 
             RowBox[{"Enabled", "\[Rule]", "enabled"}]}], "]"}]}], 
          "\[IndentingNewLine]", "}"}], "]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"SetAttributes", "[", 
        RowBox[{"slN", ",", "HoldRest"}], "]"}], ";", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"slN", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"ss_", ",", 
            RowBox[{"enabled_", ":", "True"}], ",", "allowed_"}], "}"}], ",", 
          
          RowBox[{"post_", ":", "Identity"}]}], "]"}], ":=", 
        "\[IndentingNewLine]", 
        RowBox[{"Row", "[", 
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"Slider", "[", 
            RowBox[{
             RowBox[{"Dynamic", "[", 
              RowBox[{"ss", ",", 
               RowBox[{"{", 
                RowBox[{
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{"ss", "=", "#"}], ")"}], "&"}], ",", 
                 RowBox[{
                  RowBox[{"(", " ", "post", ")"}], "&"}]}], "}"}]}], "]"}], 
             ",", 
             RowBox[{"{", "allowed", "}"}], ",", 
             RowBox[{"Enabled", "\[Rule]", "enabled"}]}], "]"}], ",", 
           "\[IndentingNewLine]", "\"\<       \>\"", ",", 
           "\[IndentingNewLine]", 
           RowBox[{"InputField", "[", 
            RowBox[{
             RowBox[{"Dynamic", "[", 
              RowBox[{
               RowBox[{"IntegerPart", "[", "ss", "]"}], ",", 
               RowBox[{"{", 
                RowBox[{
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{"ss", "=", "#"}], ")"}], "&"}], ",", 
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{
                    RowBox[{"ss", "=", 
                    RowBox[{"First", "@", 
                    RowBox[{"Nearest", "[", 
                    RowBox[{"allowed", ",", "#"}], "]"}]}]}], ";", " ", 
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{"NumericQ", "[", "ss", "]"}], ",", "post"}], 
                    "]"}], ";"}], ")"}], "&"}]}], "}"}]}], "]"}], ",", 
             "Number", ",", 
             RowBox[{"FieldSize", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"4", ",", "1"}], "}"}]}], ",", 
             RowBox[{"Enabled", "\[Rule]", "enabled"}]}], "]"}]}], 
          "\[IndentingNewLine]", "}"}], "]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"SetAttributes", "[", 
        RowBox[{"hg", ",", "HoldRest"}], "]"}], ";", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{"hg", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{"ss_", ",", "col_Integer", ",", 
            RowBox[{"min_", ":", "0.001"}], ",", 
            RowBox[{"max_", ":", "0.3"}], ",", 
            RowBox[{"step_", ":", "0.001"}]}], "}"}], ",", "post_"}], "]"}], ":=", 
        RowBox[{"Row", "[", 
         RowBox[{"{", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"HorizontalGauge", "[", 
            RowBox[{
             RowBox[{"Dynamic", "[", 
              RowBox[{"ss", ",", 
               RowBox[{"{", "\[IndentingNewLine]", 
                RowBox[{
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{"ss", "=", "#"}], ")"}], "&"}], ",", 
                 "\[IndentingNewLine]", 
                 RowBox[{
                  RowBox[{"(", "post", ")"}], "&"}]}], "}"}]}], "]"}], ",", 
             RowBox[{"{", 
              RowBox[{"min", ",", "max"}], "}"}], ",", 
             RowBox[{"GaugeStyle", "\[Rule]", 
              RowBox[{"colors", "[", "col", "]"}]}], ",", 
             RowBox[{"PerformanceGoal", "\[Rule]", "\"\<Speed\>\""}], ",", 
             RowBox[{"ScaleDivisions", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"10", ",", "10"}], "}"}]}], ",", 
             RowBox[{"GaugeLabels", "\[Rule]", "None"}], ",", 
             RowBox[{"ScalePadding", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"0.1", ",", "0"}], "}"}]}], ",", 
             RowBox[{"ImageSize", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"230", ",", "32"}], "}"}]}], ",", 
             RowBox[{"ScaleOrigin", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"0", ",", 
                RowBox[{"{", 
                 RowBox[{"0", ",", "1"}], "}"}]}], "}"}]}], ",", 
             RowBox[{"GaugeFrameSize", "\[Rule]", "None"}]}], "]"}], ",", 
           "\[IndentingNewLine]", 
           RowBox[{"InputField", " ", "[", 
            RowBox[{
             RowBox[{"Dynamic", "[", " ", 
              RowBox[{
               RowBox[{"SetAccuracy", "[", 
                RowBox[{"ss", ",", "4"}], "]"}], ",", 
               RowBox[{"{", 
                RowBox[{
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{"ss", "=", "#"}], 
                   RowBox[{"(*", 
                    RowBox[{"cost", "[", 
                    RowBox[{"#", ",", 
                    RowBox[{"{", 
                    RowBox[{"min", ",", "max", ",", "step"}], "}"}]}], "]"}], 
                    "*)"}], ")"}], "&"}], ",", 
                 RowBox[{
                  RowBox[{"(", 
                   RowBox[{
                    RowBox[{"ss", "=", 
                    RowBox[{"cost", "[", 
                    RowBox[{"#", ",", 
                    RowBox[{"{", 
                    RowBox[{"min", ",", "max", ",", "step"}], "}"}]}], 
                    "]"}]}], ";", "  ", 
                    RowBox[{"If", "[", 
                    RowBox[{
                    RowBox[{"NumericQ", "[", "ss", "]"}], ",", "post"}], 
                    "]"}]}], ")"}], "&"}]}], "}"}]}], "]"}], ",", "Number", 
             ",", 
             RowBox[{"FieldSize", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"4", ",", "1"}], "}"}]}]}], "]"}]}], 
          "\[IndentingNewLine]", "}"}], "]"}]}], ";", "\[IndentingNewLine]", 
       "\[IndentingNewLine]", 
       RowBox[{"n", "=", "25"}], ";", 
       RowBox[{"network", "=", "\"\<Grid\>\""}], ";", 
       RowBox[{"\[Rho]", "=", "0.2"}], ";", 
       RowBox[{"k", "=", "2"}], ";", "\[IndentingNewLine]", 
       RowBox[{"p", "=", "3"}], ";", 
       RowBox[{"t", "=", "1"}], ";", "\[IndentingNewLine]", 
       RowBox[{"\[Lambda]", "=", "0.2"}], ";", 
       RowBox[{"o", "=", "0.05"}], ";", 
       RowBox[{"d", "=", "0.005"}], ";", 
       RowBox[{"g", "=", "0.01"}], ";", "\[IndentingNewLine]", 
       RowBox[{"detCanInfect", "=", "True"}], ";", "\[IndentingNewLine]", 
       RowBox[{"groups", "=", 
        RowBox[{"{", 
         RowBox[{"1", ",", "2", ",", "3", ",", "4", ",", "5"}], "}"}]}], ";", 
       
       RowBox[{"tmax", "=", "hardtmax"}], ";", "\[IndentingNewLine]", 
       RowBox[{"merge", "=", "False"}], ";", "\[IndentingNewLine]", 
       RowBox[{"merge2", "=", "False"}], ";", "\[IndentingNewLine]", 
       RowBox[{"c", "[", "\"\<refreshColors\>\"", "]"}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"c", "[", "\"\<all\>\"", "]"}]}], ")"}]}]}], "]"}]}]], "Input",\

 CellLabel->"In[1]:=",
 CellID->692615483,ExpressionUUID->"51a44a3f-ad0e-46da-a77e-94c697082644"],

Cell[BoxData[
 DynamicModuleBox[{$CellContext`n$$ = 25, $CellContext`\[Rho]$$ = 
  0.2, $CellContext`k$$ = 2, $CellContext`network$$ = 
  "Grid", $CellContext`graph$$ = 
  Graph[{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 
   20, 21, 22, 23, 24, 25}, {Null, 
    SparseArray[
    Automatic, {25, 25}, 0, {
     1, {{0, 2, 5, 8, 11, 13, 16, 20, 24, 28, 31, 34, 38, 42, 46, 49, 52, 56, 
       60, 64, 67, 69, 72, 75, 78, 80}, {{2}, {6}, {1}, {3}, {7}, {2}, {4}, {
       8}, {3}, {5}, {9}, {4}, {10}, {1}, {7}, {11}, {2}, {6}, {8}, {12}, {
       3}, {7}, {9}, {13}, {4}, {8}, {10}, {14}, {5}, {9}, {15}, {6}, {12}, {
       16}, {7}, {11}, {13}, {17}, {8}, {12}, {14}, {18}, {9}, {13}, {15}, {
       19}, {10}, {14}, {20}, {11}, {17}, {21}, {12}, {16}, {18}, {22}, {
       13}, {17}, {19}, {23}, {14}, {18}, {20}, {24}, {15}, {19}, {25}, {
       16}, {22}, {17}, {21}, {23}, {18}, {22}, {24}, {19}, {23}, {25}, {
       20}, {24}}}, Pattern}]}, {BaseStyle -> EdgeForm[], EdgeStyle -> {
      RGBColor[0.7777777777777778, 0.7777777777777778, 0.7777777777777778]}, 
    GraphLayout -> {
     "Dimension" -> 2, 
      "VertexLayout" -> {"GridEmbedding", "Dimension" -> {5, 5}}}, 
    ImageMargins -> 0, ImagePadding -> 0, ImageSize -> {500, 500}, 
    VertexSize -> {0.6}, VertexStyle -> {
      RGBColor[
      0.6666666666666666, 0.6666666666666666, 
       0.6666666666666666]}}], $CellContext`initialList$$ = {3, 3, 1, 3, 1, 3,
   3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 3, 3, 3, 3, 3, 3, 3, 
  3}, $CellContext`p$$ = 3, $CellContext`t$$ = 1, $CellContext`\[Lambda]$$ = 
  0.2, $CellContext`o$$ = 0.05, $CellContext`d$$ = 0.005, $CellContext`g$$ = 
  0.01, $CellContext`detCanInfect$$ = 
  True, $CellContext`courseOfEpidemics$$ = CompressedData["
1:eJztzEsOwyAMBFBmMIfoslfqEaLue/9d+QQBFSEFJVEWYNlYfpafy+e1UCn1
tvmwqTVspIe8LQBZ2wLEM2kNAdbU4ivCPHwahAckCGoBFvgLAOlAEA6zAERA
DSBuuA+mH2iBAUwBUgVuAFeQCH5nEHgecBRkG0wVmAN7wIwArwRzGEgnyBjw
psDzgf+C3APMDrhogUzoBzkUZMKEBnwB/CYg6A==
  "], $CellContext`size$$ = 
  25, $CellContext`tmax$$ = 100, $CellContext`ls$$ = 
  None, $CellContext`stats$$ = {{
    Rational[3, 25], 
    Rational[4, 25], 
    Rational[1, 5], 
    Rational[8, 25], 
    Rational[11, 25], 
    Rational[14, 25], 
    Rational[16, 25], 
    Rational[17, 25], 
    Rational[18, 25], 
    Rational[18, 25], 
    Rational[18, 25], 
    Rational[17, 25], 
    Rational[17, 25], 
    Rational[3, 5], 
    Rational[3, 5], 
    Rational[14, 25], 
    Rational[12, 25], 
    Rational[11, 25], 
    Rational[11, 25], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[1, 25], 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0}, {0, 0, 0, 0, 0, 
    Rational[1, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[3, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[1, 5], 
    Rational[4, 25], 
    Rational[1, 5], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[7, 25], 
    Rational[6, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[8, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[9, 25], 
    Rational[7, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25]}, {
    Rational[22, 25], 
    Rational[21, 25], 
    Rational[4, 5], 
    Rational[17, 25], 
    Rational[13, 25], 
    Rational[9, 25], 
    Rational[6, 25], 
    Rational[4, 25], 
    Rational[2, 25], 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {
   0, 0, 0, 0, 
    Rational[1, 25], 
    Rational[1, 25], 
    Rational[1, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[1, 5], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[6, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[8, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[9, 25], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[2, 5], 
    Rational[11, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[12, 25], 
    Rational[13, 25], 
    Rational[13, 25], 
    Rational[13, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25], 
    Rational[14, 25]}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    Rational[1, 25], 
    Rational[1, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[2, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[3, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[4, 25], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[1, 5], 
    Rational[6, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25], 
    Rational[7, 25]}}, $CellContext`statsLock$$, $CellContext`groups$$ = {1, 
  2, 3, 4, 5}, $CellContext`c$$, $CellContext`status$$, $CellContext`locks$$ \
= {}, $CellContext`locksTmp$$, $CellContext`merge$$ = 
  False, $CellContext`merge2$$ = False, $CellContext`gColors$$ = Association[
  1 -> RGBColor[1, 0, 0], 2 -> RGBColor[1, 0.6666666666666666, 
     Rational[1, 3]], 3 -> 
   RGBColor[0.6666666666666666, 0.6666666666666666, 0.6666666666666666], 4 -> 
   RGBColor[0.54, 1., 0.94], 5 -> GrayLevel[0]], $CellContext`CommunityQ$$ = 
  False}, 
  TagBox[
   TagBox[GridBox[{
      {
       PanelBox[
        TagBox[GridBox[{
           {"\<\"\"\>", 
            ItemBox[
             TagBox[
              TooltipBox[
               StyleBox["\<\"Network Parameters\"\>",
                StripOnInput->False,
                FontSize->16,
                FontWeight->Bold],
               "\"Parameters that regulate shape and size of the networks.\"",
               
               TooltipStyle->"TextStyling"],
              
              Annotation[#, 
               "Parameters that regulate shape and size of the networks.", 
               "Tooltip"]& ],
             ContinuousAction -> True,
             Alignment->Center,
             StripOnInput->False]},
           {
            ItemBox["\<\"\"\>",
             StripOnInput->False], 
            ItemBox["\<\"\"\>",
             StripOnInput->False]},
           {
            TagBox[
             TooltipBox["\<\"Population size: \"\>",
              
              "\"Maximal number of the nodes in the network. In random \
networks, e.g. \\\"Holed Grid\\\" the number of nodes can be lower than this.\
\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, 
              "Maximal number of the nodes in the network. In random \
networks, e.g. \"Holed Grid\" the number of nodes can be lower than this.", 
              "Tooltip"]& ], 
            TemplateBox[{
              SliderBox[
               
               Dynamic[$CellContext`n$$, {($CellContext`n$$ = #)& , \
$CellContext`c$$["all"]& }], {{16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 
               196, 225, 256, 289, 324, 361, 400, 441, 484, 529, 576, 625, 
               676, 729, 784, 841, 900}}, Enabled -> True], "\"       \"", 
              InputFieldBox[
               Dynamic[
                
                IntegerPart[$CellContext`n$$], {($CellContext`n$$ = #)& , \
($CellContext`n$$ = First[
                    
                    Nearest[{16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 
                    225, 256, 289, 324, 361, 400, 441, 484, 529, 576, 625, 
                    676, 729, 784, 841, 900}, #]]; If[
                   NumericQ[$CellContext`n$$], 
                   $CellContext`c$$["all"]]; Null)& }], Number, 
               FieldSize -> {4, 1}, Enabled -> True]},
             "RowDefault"]},
           {
            TagBox[
             TooltipBox["\<\"Network type: \"\>",
              "\"Choose the type of network.\"",
              TooltipStyle->"TextStyling"],
             Annotation[#, "Choose the type of network.", "Tooltip"]& ], 
            InterpretationBox[
             StyleBox[GridBox[{
                {GridBox[{
                   {
                    
                    RadioButtonBox[
                    Dynamic[$CellContext`network$$, {($CellContext`network$$ = \
#)& , ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {"Grid"},
                    DefaultBaseStyle->"RadioButtonBar"], 
                    StyleBox[
                    TagBox[
                    TooltipBox["\<\"Grid\"\>",
                    
                    "\"Lattice network of edge \
\\!\\(\\*SqrtBox[\\(n\\)]\\).\\nSee GridGraph in Mathematica.\"",
                    TooltipStyle->"TextStyling"],
                    
                    Annotation[#, 
                    "Lattice network of edge \!\(\*SqrtBox[\(n\)]\).\nSee \
GridGraph in Mathematica.", "Tooltip"]& ], "RadioButtonBarLabel",
                    StripOnInput->False]}
                  },
                  AutoDelete->False,
                  BaselinePosition->{1, 2},
                  
                  GridBoxAlignment->{
                   "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
                  GridBoxSpacings->{"Columns" -> {
                    Offset[0.27999999999999997`], {
                    Offset[0.21]}, 
                    Offset[0.27999999999999997`]}, "Rows" -> {
                    Offset[0.2], {
                    Offset[0.4]}, 
                    Offset[0.2]}}], GridBox[{
                   {
                    
                    RadioButtonBox[
                    Dynamic[$CellContext`network$$, {($CellContext`network$$ = \
#)& , ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {
                    "Holed Grid"},
                    DefaultBaseStyle->"RadioButtonBar"], 
                    StyleBox[
                    TagBox[
                    TooltipBox["\<\"Holed Grid\"\>",
                    
                    "\"Random network based on grid graph with some vertices \
removed.\\nSee holedGrid function definition.\"",
                    TooltipStyle->"TextStyling"],
                    
                    Annotation[#, 
                    "Random network based on grid graph with some vertices \
removed.\nSee holedGrid function definition.", "Tooltip"]& ], 
                    "RadioButtonBarLabel",
                    StripOnInput->False]}
                  },
                  AutoDelete->False,
                  BaselinePosition->{1, 2},
                  
                  GridBoxAlignment->{
                   "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
                  GridBoxSpacings->{"Columns" -> {
                    Offset[0.27999999999999997`], {
                    Offset[0.21]}, 
                    Offset[0.27999999999999997`]}, "Rows" -> {
                    Offset[0.2], {
                    Offset[0.4]}, 
                    Offset[0.2]}}]},
                {GridBox[{
                   {
                    
                    RadioButtonBox[
                    Dynamic[$CellContext`network$$, {($CellContext`network$$ = \
#)& , ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {
                    "Scale-Free"},
                    DefaultBaseStyle->"RadioButtonBar"], 
                    StyleBox[
                    TagBox[
                    TooltipBox["\<\"Scale-Free\"\>",
                    
                    "\"Random network built on top of 3-vertex cycle \
graph.\\nSee BarabasiAlbertGraphDistribution in Mathematica.\"",
                    TooltipStyle->"TextStyling"],
                    
                    Annotation[#, 
                    "Random network built on top of 3-vertex cycle graph.\n\
See BarabasiAlbertGraphDistribution in Mathematica.", "Tooltip"]& ], 
                    "RadioButtonBarLabel",
                    StripOnInput->False]}
                  },
                  AutoDelete->False,
                  BaselinePosition->{1, 2},
                  
                  GridBoxAlignment->{
                   "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
                  GridBoxSpacings->{"Columns" -> {
                    Offset[0.27999999999999997`], {
                    Offset[0.21]}, 
                    Offset[0.27999999999999997`]}, "Rows" -> {
                    Offset[0.2], {
                    Offset[0.4]}, 
                    Offset[0.2]}}], GridBox[{
                   {
                    
                    RadioButtonBox[
                    Dynamic[$CellContext`network$$, {($CellContext`network$$ = \
#)& , ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {"Random"},
                    DefaultBaseStyle->"RadioButtonBar"], 
                    StyleBox[
                    TagBox[
                    TooltipBox["\<\"Random\"\>",
                    "\"Random network.\\nSee RandomGraph in Mathematica.\"",
                    TooltipStyle->"TextStyling"],
                    
                    Annotation[#, 
                    "Random network.\nSee RandomGraph in Mathematica.", 
                    "Tooltip"]& ], "RadioButtonBarLabel",
                    StripOnInput->False]}
                  },
                  AutoDelete->False,
                  BaselinePosition->{1, 2},
                  
                  GridBoxAlignment->{
                   "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
                  GridBoxSpacings->{"Columns" -> {
                    Offset[0.27999999999999997`], {
                    Offset[0.21]}, 
                    Offset[0.27999999999999997`]}, "Rows" -> {
                    Offset[0.2], {
                    Offset[0.4]}, 
                    Offset[0.2]}}]},
                {GridBox[{
                   {
                    
                    RadioButtonBox[
                    Dynamic[$CellContext`network$$, {($CellContext`network$$ = \
#)& , ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {
                    "Small-World (WS)"},
                    DefaultBaseStyle->"RadioButtonBar"], 
                    StyleBox[
                    TagBox[
                    TooltipBox["\<\"Small-World (WS)\"\>",
                    
                    "\"Random network based on 2k\[Dash]regular graph.\\nSee \
WattsStrogatzGraphDistribution in Mathematica.\"",
                    TooltipStyle->"TextStyling"],
                    
                    Annotation[#, 
                    "Random network based on 2k\[Dash]regular graph.\nSee \
WattsStrogatzGraphDistribution in Mathematica.", "Tooltip"]& ], 
                    "RadioButtonBarLabel",
                    StripOnInput->False]}
                  },
                  AutoDelete->False,
                  BaselinePosition->{1, 2},
                  
                  GridBoxAlignment->{
                   "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
                  GridBoxSpacings->{"Columns" -> {
                    Offset[0.27999999999999997`], {
                    Offset[0.21]}, 
                    Offset[0.27999999999999997`]}, "Rows" -> {
                    Offset[0.2], {
                    Offset[0.4]}, 
                    Offset[0.2]}}], GridBox[{
                   {
                    
                    RadioButtonBox[
                    Dynamic[$CellContext`network$$, {($CellContext`network$$ = \
#)& , ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {"k-Grid"},
                    DefaultBaseStyle->"RadioButtonBar"], 
                    StyleBox[
                    TagBox[
                    TooltipBox["\<\"k-Grid\"\>",
                    
                    "\"Lattice network with k nearest neighbours.\\nSee \
advGrid function definition.\"",
                    TooltipStyle->"TextStyling"],
                    
                    Annotation[#, 
                    "Lattice network with k nearest neighbours.\nSee advGrid \
function definition.", "Tooltip"]& ], "RadioButtonBarLabel",
                    StripOnInput->False]}
                  },
                  AutoDelete->False,
                  BaselinePosition->{1, 2},
                  
                  GridBoxAlignment->{
                   "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
                  GridBoxSpacings->{"Columns" -> {
                    Offset[0.27999999999999997`], {
                    Offset[0.21]}, 
                    Offset[0.27999999999999997`]}, "Rows" -> {
                    Offset[0.2], {
                    Offset[0.4]}, 
                    Offset[0.2]}}]},
                {GridBox[{
                   {
                    
                    RadioButtonBox[
                    Dynamic[$CellContext`network$$, {($CellContext`network$$ = \
#)& , ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {
                    "Small-World (KM)"},
                    DefaultBaseStyle->"RadioButtonBar"], 
                    StyleBox[
                    TagBox[
                    TooltipBox["\<\"Small-World (KM)\"\>",
                    
                    "\"Random network based on grid graph.\\nSee gridBasedSW \
function definition.\"",
                    TooltipStyle->"TextStyling"],
                    
                    Annotation[#, 
                    "Random network based on grid graph.\nSee gridBasedSW \
function definition.", "Tooltip"]& ], "RadioButtonBarLabel",
                    StripOnInput->False]}
                  },
                  AutoDelete->False,
                  BaselinePosition->{1, 2},
                  
                  GridBoxAlignment->{
                   "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
                  GridBoxSpacings->{"Columns" -> {
                    Offset[0.27999999999999997`], {
                    Offset[0.21]}, 
                    Offset[0.27999999999999997`]}, "Rows" -> {
                    Offset[0.2], {
                    Offset[0.4]}, 
                    Offset[0.2]}}], GridBox[{
                   {
                    
                    RadioButtonBox[
                    Dynamic[$CellContext`network$$, {($CellContext`network$$ = \
#)& , ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {
                    "2k-regular"},
                    DefaultBaseStyle->"RadioButtonBar"], 
                    StyleBox[
                    TagBox[
                    TooltipBox["\<\"2k-regular\"\>",
                    
                    "\"Circular network with k nearest neighbours.\\nSee \
CirculantGraph in Mathematica.\"",
                    TooltipStyle->"TextStyling"],
                    
                    Annotation[#, 
                    "Circular network with k nearest neighbours.\nSee \
CirculantGraph in Mathematica.", "Tooltip"]& ], "RadioButtonBarLabel",
                    StripOnInput->False]}
                  },
                  AutoDelete->False,
                  BaselinePosition->{1, 2},
                  
                  GridBoxAlignment->{
                   "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
                  
                  GridBoxItemSize->{
                   "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
                  GridBoxSpacings->{"Columns" -> {
                    Offset[0.27999999999999997`], {
                    Offset[0.21]}, 
                    Offset[0.27999999999999997`]}, "Rows" -> {
                    Offset[0.2], {
                    Offset[0.4]}, 
                    Offset[0.2]}}]}
               },
               
               GridBoxAlignment->{
                "Columns" -> {{Left}}, "Rows" -> {{Baseline}}},
               GridBoxSpacings->{"Columns" -> {
                   Offset[0.27999999999999997`], {
                    Offset[1.4]}, 
                   Offset[0.27999999999999997`]}, "Rows" -> {
                   Offset[0.2], {
                    Offset[0.4]}, 
                   Offset[0.2]}}], "Deploy"],
             RadioButtonBar[
              
              Dynamic[$CellContext`network$$, {($CellContext`network$$ = #)& \
, ($CellContext`network$$ = #; $CellContext`c$$["all"])& }], {
              "Grid" -> Tooltip[
                "Grid", 
                 "Lattice network of edge \!\(\*SqrtBox[\(n\)]\).\nSee \
GridGraph in Mathematica."], "Scale-Free" -> 
               Tooltip[
                "Scale-Free", 
                 "Random network built on top of 3-vertex cycle graph.\nSee \
BarabasiAlbertGraphDistribution in Mathematica."], "Small-World (WS)" -> 
               Tooltip[
                "Small-World (WS)", 
                 "Random network based on 2k\[Dash]regular graph.\nSee \
WattsStrogatzGraphDistribution in Mathematica."], "Small-World (KM)" -> 
               Tooltip[
                "Small-World (KM)", 
                 "Random network based on grid graph.\nSee gridBasedSW \
function definition."], "Holed Grid" -> 
               Tooltip[
                "Holed Grid", 
                 "Random network based on grid graph with some vertices \
removed.\nSee holedGrid function definition."], "Random" -> 
               Tooltip[
                "Random", "Random network.\nSee RandomGraph in Mathematica."],
                "k-Grid" -> 
               Tooltip[
                "k-Grid", 
                 "Lattice network with k nearest neighbours.\nSee advGrid \
function definition."], "2k-regular" -> 
               Tooltip[
                "2k-regular", 
                 "Circular network with k nearest neighbours.\nSee \
CirculantGraph in Mathematica."]}, 
              Appearance -> ("Vertical" -> {Automatic, 2})]]},
           {
            TagBox[
             TooltipBox["\<\"Show communities:\"\>",
              
              "\"Changes layout of graph from grid embedding into embedding \
where communities are separated.\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, 
              "Changes layout of graph from grid embedding into embedding \
where communities are separated.", "Tooltip"]& ], 
            CheckboxBox[Dynamic[$CellContext`CommunityQ$$], {False, True}]},
           {
            DynamicBox[ToBoxes[
              Tooltip["\[Rho]:", 
               $CellContext`\[Rho]Tooltip[$CellContext`network$$]], 
              StandardForm],
             ImageSizeCache->{12., {3., 8.}}], 
            TemplateBox[{
              SliderBox[
               
               Dynamic[$CellContext`\[Rho]$$, {($CellContext`\[Rho]$$ = #)& , \
$CellContext`c$$["all"]& }], {0.001, 1, 0.001}, Enabled -> Dynamic[
                 $CellContext`rhoEnabled[$CellContext`network$$]]], 
              "\"       \"", 
              InputFieldBox[
               Dynamic[
                If[
                 IntegerQ[0.001], 
                 IntegerPart[$CellContext`\[Rho]$$], 
                 SetAccuracy[$CellContext`\[Rho]$$, 
                  4]], {($CellContext`\[Rho]$$ = #)& , ($CellContext`\[Rho]$$ = \
#; If[
                   NumericQ[$CellContext`\[Rho]$$], 
                   $CellContext`c$$["all"]])& }], Number, FieldSize -> {4, 1},
                Enabled -> Dynamic[
                 $CellContext`rhoEnabled[$CellContext`network$$]]]},
             "RowDefault"]},
           {
            DynamicBox[ToBoxes[
              Tooltip["k: ", 
               $CellContext`kTooltip[$CellContext`network$$]], StandardForm],
             ImageSizeCache->{14., {1., 11.}}], 
            TemplateBox[{
              SliderBox[
               
               Dynamic[$CellContext`k$$, {($CellContext`k$$ = #)& , \
$CellContext`c$$["all"]& }], {1, 6, 1}, Enabled -> Dynamic[
                 $CellContext`kEnabled[$CellContext`network$$]]], 
              "\"       \"", 
              InputFieldBox[
               Dynamic[
                If[
                 IntegerQ[1], 
                 IntegerPart[$CellContext`k$$], 
                 
                 SetAccuracy[$CellContext`k$$, 
                  4]], {($CellContext`k$$ = #)& , ($CellContext`k$$ = #; If[
                   NumericQ[$CellContext`k$$], 
                   $CellContext`c$$["all"]])& }], Number, FieldSize -> {4, 1},
                Enabled -> Dynamic[
                 $CellContext`kEnabled[$CellContext`network$$]]]},
             "RowDefault"]},
           {"\<\"\"\>", 
            ItemBox[
             TagBox[
              TooltipBox[
               ButtonBox["\<\"Reshuffle network\"\>",
                Appearance->Automatic,
                ButtonFunction:>$CellContext`c$$["all"],
                Evaluator->Automatic,
                Method->"Preemptive"],
               
               "\"Pick new random graph with the same parameters and redo the \
simulation.\"",
               TooltipStyle->"TextStyling"],
              
              Annotation[#, 
               "Pick new random graph with the same parameters and redo the \
simulation.", "Tooltip"]& ],
             ContinuousAction -> True,
             Alignment->Center,
             StripOnInput->False]},
           {
            ItemBox["\<\"\"\>",
             StripOnInput->False], 
            ItemBox["\<\"\"\>",
             StripOnInput->False]},
           {"\<\"\"\>", 
            ItemBox[
             TagBox[
              TooltipBox[
               StyleBox["\<\"Epidemic Parameters\"\>",
                StripOnInput->False,
                FontSize->16,
                FontWeight->Bold],
               "\"Set the parameters of the disease.\"",
               TooltipStyle->"TextStyling"],
              
              Annotation[#, "Set the parameters of the disease.", 
               "Tooltip"]& ],
             ContinuousAction -> True,
             Alignment->Center,
             StripOnInput->False]},
           {
            TagBox[
             TooltipBox["\<\"Number of \\ninitially infected:\"\>",
              "\"Set how many people are initially infected.\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, "Set how many people are initially infected.", 
              "Tooltip"]& ], 
            TemplateBox[{
              SliderBox[
               
               Dynamic[$CellContext`p$$, {($CellContext`p$$ = #)& , \
$CellContext`c$$["pop"]& }], {1, 10, 1}, Enabled -> True], "\"       \"", 
              InputFieldBox[
               Dynamic[
                If[
                 IntegerQ[1], 
                 IntegerPart[$CellContext`p$$], 
                 
                 SetAccuracy[$CellContext`p$$, 
                  4]], {($CellContext`p$$ = #)& , ($CellContext`p$$ = #; If[
                   NumericQ[$CellContext`p$$], 
                   $CellContext`c$$["pop"]])& }], Number, FieldSize -> {4, 1},
                Enabled -> True]},
             "RowDefault"]},
           {"\<\"\"\>", 
            ItemBox[
             TagBox[
              TooltipBox[
               ButtonBox["\<\"Reshuffle initially infected\"\>",
                Appearance->Automatic,
                ButtonFunction:>$CellContext`c$$["pop"],
                Evaluator->Automatic,
                Method->"Preemptive"],
               
               "\"Pick new set of nodes that are initially infected for the \
same graph and redo the simulation.\"",
               TooltipStyle->"TextStyling"],
              
              Annotation[#, 
               "Pick new set of nodes that are initially infected for the \
same graph and redo the simulation.", "Tooltip"]& ],
             ContinuousAction -> True,
             Alignment->Center,
             StripOnInput->False]},
           {
            TagBox[
             TooltipBox["\<\"Infection rate:\"\>",
              
              "\"Parameter that describes how fast the infection spreads. The \
bigger, the faster it is.\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, 
              "Parameter that describes how fast the infection spreads. The \
bigger, the faster it is.", "Tooltip"]& ], 
            TemplateBox[{
              DynamicModuleBox[{System`GaugesDump`height$$ = Dynamic[
                  
                  Charting`barValHeight[$CellContext`\[Lambda]$$, {
                   Identity, Identity}, {0.001, 0.9}, {{0, 0}, {1, 0}}, 0]], 
                System`GaugesDump`pt$$ = {0., 0.}}, 
               LocatorPaneBox[
                Dynamic[
                 
                 Charting`barValueToPoint[$CellContext`\[Lambda]$$, {
                  Identity, Identity}, {0.001, 0.9}, {{0, 0}, {1, 0}}, 0], {
                 None, (System`GaugesDump`height$$ = 
                   Charting`barPointtoValue[#, {Identity, Identity}, {0.001, 
                    0.9}, {{0, 0}, {1, 0}}, 0]; $CellContext`\[Lambda]$$ = (
                    Part[{None, ($CellContext`\[Lambda]$$ = #)& , \
$CellContext`c$$["evo"]& }, 2][
                    System`GaugesDump`height$$, #2]; \
$CellContext`\[Lambda]$$); 
                  System`GaugesDump`pt$$ = 
                   Charting`barValueToPoint[$CellContext`\[Lambda]$$, {
                    Identity, Identity}, {0.001, 0.9}, {{0, 0}, {1, 0}}, 0]; 
                  Null)& , $CellContext`c$$["evo"]& }, {}], 
                GraphicsBox[{{}, {
                   Opacity[0], 
                   PointBox[{{-0.1, 0.}, {1.1, 0.}}]}, 
                  
                  GeometricTransformationBox[{{}}, {{{1, 0}, {0, 1}}, {0, 
                    0}}], {
                   StyleBox[{Antialiasing -> False, 
                    StyleBox[
                    
                    LineBox[{{0., 0.}, {1., 0.}}], {{{}}, StripOnInput -> 
                    False}, StripOnInput -> False], 
                    StyleBox[
                    StyleBox[{{
                    StyleBox[
                    LineBox[{{{0.11012235817575083`, 0.}, 
                    Scaled[{0., 0.06}, {0.11012235817575083`, 0.}]}, {{
                    0.22135706340378197`, 0.}, 
                    Scaled[{0., 0.06}, {0.22135706340378197`, 0.}]}, {{
                    0.3325917686318131, 0.}, 
                    Scaled[{0., 0.06}, {0.3325917686318131, 0.}]}, {{
                    0.44382647385984425`, 0.}, 
                    Scaled[{0., 0.06}, {0.44382647385984425`, 0.}]}, {{
                    0.5550611790878753, 0.}, 
                    Scaled[{0., 0.06}, {0.5550611790878753, 0.}]}, {{
                    0.6662958843159065, 0.}, 
                    Scaled[{0., 0.06}, {0.6662958843159065, 0.}]}, {{
                    0.7775305895439376, 0.}, 
                    Scaled[{0., 0.06}, {0.7775305895439376, 0.}]}, {{
                    0.8887652947719689, 0.}, 
                    Scaled[{0., 0.06}, {0.8887652947719689, 0.}]}, {{1., 0.}, 
                    
                    Scaled[{0., 0.06}, {1., 0.}]}}], {{{}}, StripOnInput -> 
                    False}, StripOnInput -> False], 
                    StyleBox[
                    LineBox[{{{0.010011123470522803`, 0.}, 
                    Scaled[{0., 0.04}, {0.010011123470522803`, 0.}]}, {{
                    0.021134593993325915`, 0.}, 
                    Scaled[{0., 0.04}, {0.021134593993325915`, 0.}]}, {{
                    0.03225806451612903, 0.}, 
                    Scaled[{0., 0.04}, {0.03225806451612903, 0.}]}, {{
                    0.04338153503893214, 0.}, 
                    Scaled[{0., 0.04}, {0.04338153503893214, 0.}]}, {{
                    0.05450500556173526, 0.}, 
                    Scaled[{0., 0.04}, {0.05450500556173526, 0.}]}, {{
                    0.06562847608453837, 0.}, 
                    Scaled[{0., 0.04}, {0.06562847608453837, 0.}]}, {{
                    0.0767519466073415, 0.}, 
                    Scaled[{0., 0.04}, {0.0767519466073415, 0.}]}, {{
                    0.0878754171301446, 0.}, 
                    Scaled[{0., 0.04}, {0.0878754171301446, 0.}]}, {{
                    0.0989988876529477, 0.}, 
                    Scaled[{0., 0.04}, {0.0989988876529477, 0.}]}, {{
                    0.12124582869855394`, 0.}, 
                    Scaled[{0., 0.04}, {0.12124582869855394`, 0.}]}, {{
                    0.13236929922135704`, 0.}, 
                    Scaled[{0., 0.04}, {0.13236929922135704`, 0.}]}, {{
                    0.14349276974416017`, 0.}, 
                    Scaled[{0., 0.04}, {0.14349276974416017`, 0.}]}, {{
                    0.1546162402669633, 0.}, 
                    Scaled[{0., 0.04}, {0.1546162402669633, 0.}]}, {{
                    0.1657397107897664, 0.}, 
                    Scaled[{0., 0.04}, {0.1657397107897664, 0.}]}, {{
                    0.1768631813125695, 0.}, 
                    Scaled[{0., 0.04}, {0.1768631813125695, 0.}]}, {{
                    0.18798665183537264`, 0.}, 
                    Scaled[{0., 0.04}, {0.18798665183537264`, 0.}]}, {{
                    0.19911012235817574`, 0.}, 
                    Scaled[{0., 0.04}, {0.19911012235817574`, 0.}]}, {{
                    0.21023359288097884`, 0.}, 
                    Scaled[{0., 0.04}, {0.21023359288097884`, 0.}]}, {{
                    0.23248053392658508`, 0.}, 
                    Scaled[{0., 0.04}, {0.23248053392658508`, 0.}]}, {{
                    0.2436040044493882, 0.}, 
                    Scaled[{0., 0.04}, {0.2436040044493882, 0.}]}, {{
                    0.25472747497219134`, 0.}, 
                    Scaled[{0., 0.04}, {0.25472747497219134`, 0.}]}, {{
                    0.2658509454949944, 0.}, 
                    Scaled[{0., 0.04}, {0.2658509454949944, 0.}]}, {{
                    0.27697441601779754`, 0.}, 
                    Scaled[{0., 0.04}, {0.27697441601779754`, 0.}]}, {{
                    0.28809788654060065`, 0.}, 
                    Scaled[{0., 0.04}, {0.28809788654060065`, 0.}]}, {{
                    0.2992213570634038, 0.}, 
                    Scaled[{0., 0.04}, {0.2992213570634038, 0.}]}, {{
                    0.3103448275862069, 0.}, 
                    Scaled[{0., 0.04}, {0.3103448275862069, 0.}]}, {{
                    0.32146829810900995`, 0.}, 
                    Scaled[{0., 0.04}, {0.32146829810900995`, 0.}]}, {{
                    0.3437152391546162, 0.}, 
                    Scaled[{0., 0.04}, {0.3437152391546162, 0.}]}, {{
                    0.3548387096774193, 0.}, 
                    Scaled[{0., 0.04}, {0.3548387096774193, 0.}]}, {{
                    0.3659621802002225, 0.}, 
                    Scaled[{0., 0.04}, {0.3659621802002225, 0.}]}, {{
                    0.3770856507230256, 0.}, 
                    Scaled[{0., 0.04}, {0.3770856507230256, 0.}]}, {{
                    0.3882091212458286, 0.}, 
                    Scaled[{0., 0.04}, {0.3882091212458286, 0.}]}, {{
                    0.3993325917686318, 0.}, 
                    Scaled[{0., 0.04}, {0.3993325917686318, 0.}]}, {{
                    0.4104560622914349, 0.}, 
                    Scaled[{0., 0.04}, {0.4104560622914349, 0.}]}, {{
                    0.42157953281423804`, 0.}, 
                    Scaled[{0., 0.04}, {0.42157953281423804`, 0.}]}, {{
                    0.43270300333704115`, 0.}, 
                    Scaled[{0., 0.04}, {0.43270300333704115`, 0.}]}, {{
                    0.45494994438264735`, 0.}, 
                    Scaled[{0., 0.04}, {0.45494994438264735`, 0.}]}, {{
                    0.46607341490545046`, 0.}, 
                    Scaled[{0., 0.04}, {0.46607341490545046`, 0.}]}, {{
                    0.47719688542825356`, 0.}, 
                    Scaled[{0., 0.04}, {0.47719688542825356`, 0.}]}, {{
                    0.4883203559510567, 0.}, 
                    Scaled[{0., 0.04}, {0.4883203559510567, 0.}]}, {{
                    0.4994438264738598, 0.}, 
                    Scaled[{0., 0.04}, {0.4994438264738598, 0.}]}, {{
                    0.5105672969966629, 0.}, 
                    Scaled[{0., 0.04}, {0.5105672969966629, 0.}]}, {{
                    0.521690767519466, 0.}, 
                    Scaled[{0., 0.04}, {0.521690767519466, 0.}]}, {{
                    0.5328142380422691, 0.}, 
                    Scaled[{0., 0.04}, {0.5328142380422691, 0.}]}, {{
                    0.5439377085650723, 0.}, 
                    Scaled[{0., 0.04}, {0.5439377085650723, 0.}]}, {{
                    0.5661846496106785, 0.}, 
                    Scaled[{0., 0.04}, {0.5661846496106785, 0.}]}, {{
                    0.5773081201334817, 0.}, 
                    Scaled[{0., 0.04}, {0.5773081201334817, 0.}]}, {{
                    0.5884315906562847, 0.}, 
                    Scaled[{0., 0.04}, {0.5884315906562847, 0.}]}, {{
                    0.5995550611790879, 0.}, 
                    Scaled[{0., 0.04}, {0.5995550611790879, 0.}]}, {{
                    0.610678531701891, 0.}, 
                    Scaled[{0., 0.04}, {0.610678531701891, 0.}]}, {{
                    0.6218020022246942, 0.}, 
                    Scaled[{0., 0.04}, {0.6218020022246942, 0.}]}, {{
                    0.6329254727474971, 0.}, 
                    Scaled[{0., 0.04}, {0.6329254727474971, 0.}]}, {{
                    0.6440489432703003, 0.}, 
                    Scaled[{0., 0.04}, {0.6440489432703003, 0.}]}, {{
                    0.6551724137931034, 0.}, 
                    Scaled[{0., 0.04}, {0.6551724137931034, 0.}]}, {{
                    0.6774193548387096, 0.}, 
                    Scaled[{0., 0.04}, {0.6774193548387096, 0.}]}, {{
                    0.6885428253615128, 0.}, 
                    Scaled[{0., 0.04}, {0.6885428253615128, 0.}]}, {{
                    0.6996662958843158, 0.}, 
                    Scaled[{0., 0.04}, {0.6996662958843158, 0.}]}, {{
                    0.710789766407119, 0.}, 
                    Scaled[{0., 0.04}, {0.710789766407119, 0.}]}, {{
                    0.7219132369299222, 0.}, 
                    Scaled[{0., 0.04}, {0.7219132369299222, 0.}]}, {{
                    0.7330367074527252, 0.}, 
                    Scaled[{0., 0.04}, {0.7330367074527252, 0.}]}, {{
                    0.7441601779755284, 0.}, 
                    Scaled[{0., 0.04}, {0.7441601779755284, 0.}]}, {{
                    0.7552836484983315, 0.}, 
                    Scaled[{0., 0.04}, {0.7552836484983315, 0.}]}, {{
                    0.7664071190211345, 0.}, 
                    Scaled[{0., 0.04}, {0.7664071190211345, 0.}]}, {{
                    0.7886540600667408, 0.}, 
                    Scaled[{0., 0.04}, {0.7886540600667408, 0.}]}, {{
                    0.7997775305895438, 0.}, 
                    Scaled[{0., 0.04}, {0.7997775305895438, 0.}]}, {{
                    0.810901001112347, 0.}, 
                    Scaled[{0., 0.04}, {0.810901001112347, 0.}]}, {{
                    0.8220244716351501, 0.}, 
                    Scaled[{0., 0.04}, {0.8220244716351501, 0.}]}, {{
                    0.8331479421579532, 0.}, 
                    Scaled[{0., 0.04}, {0.8331479421579532, 0.}]}, {{
                    0.8442714126807563, 0.}, 
                    Scaled[{0., 0.04}, {0.8442714126807563, 0.}]}, {{
                    0.8553948832035595, 0.}, 
                    Scaled[{0., 0.04}, {0.8553948832035595, 0.}]}, {{
                    0.8665183537263625, 0.}, 
                    Scaled[{0., 0.04}, {0.8665183537263625, 0.}]}, {{
                    0.8776418242491657, 0.}, 
                    Scaled[{0., 0.04}, {0.8776418242491657, 0.}]}, {{
                    0.899888765294772, 0.}, 
                    Scaled[{0., 0.04}, {0.899888765294772, 0.}]}, {{
                    0.911012235817575, 0.}, 
                    Scaled[{0., 0.04}, {0.911012235817575, 0.}]}, {{
                    0.9221357063403781, 0.}, 
                    Scaled[{0., 0.04}, {0.9221357063403781, 0.}]}, {{
                    0.9332591768631813, 0.}, 
                    Scaled[{0., 0.04}, {0.9332591768631813, 0.}]}, {{
                    0.9443826473859843, 0.}, 
                    Scaled[{0., 0.04}, {0.9443826473859843, 0.}]}, {{
                    0.9555061179087875, 0.}, 
                    Scaled[{0., 0.04}, {0.9555061179087875, 0.}]}, {{
                    0.9666295884315906, 0.}, 
                    Scaled[{0., 0.04}, {0.9666295884315906, 0.}]}, {{
                    0.9777530589543937, 0.}, 
                    Scaled[{0., 0.04}, {0.9777530589543937, 0.}]}, {{
                    0.9888765294771968, 0.}, 
                    Scaled[{0., 0.04}, {0.9888765294771968, 0.}]}}], {{{}}, 
                    StripOnInput -> False}, StripOnInput -> False]}, 
                    StyleBox[
                    StyleBox[{{
                    StyleBox[{
                    InsetBox[
                    BoxData[
                    FormBox["0.1`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.11012235817575083`, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.2`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.22135706340378197`, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.3`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.3325917686318131, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.4`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.44382647385984425`, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.5`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.5550611790878753, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.6`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.6662958843159065, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.7`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.7775305895439376, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.8`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.8887652947719689, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.9`", TraditionalForm]], 
                    Offset[{0., -3.}, {1., 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 
                    0}]}, {{{}, {{}, {}}}, StripOnInput -> False}, 
                    StripOnInput -> False], 
                    
                    StyleBox[{{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}, {{{}, {{}, {}}}, 
                    StripOnInput -> False}, StripOnInput -> 
                    False]}, {}}, {{{}}, StripOnInput -> False}, StripOnInput -> 
                    False], {{{
                    GrayLevel[0.25], FontSize -> 10, FontFamily -> 
                    "Helvetica"}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {{{
                    Directive[
                    CapForm["Butt"], 
                    AbsoluteThickness[1], 
                    GrayLevel[0.5]], 
                    Directive[
                    CapForm["Butt"], 
                    AbsoluteThickness[0.5], 
                    GrayLevel[0.5]]}}, StripOnInput -> False}, StripOnInput -> 
                    False], {{{}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {{
                    Directive[
                    AbsoluteThickness[1], 
                    GrayLevel[0.5]]}, StripOnInput -> False}, StripOnInput -> 
                    False], {}}, {}, {
                   Directive[
                    RGBColor[1, 0, 0]], 
                   GeometricTransformationBox[{{}, 
                    Directive[
                    RGBColor[1, 0, 0]], {}, "MarkerRotation" -> 0, 
                    TagBox[
                    TooltipBox[
                    PolygonBox[{{0.5, 0.5}, {-0.5, 0.5}, {0., -0.5}}], 
                    DynamicBox[
                    ToBoxes[$CellContext`\[Lambda]$$, StandardForm]]], 
                    Annotation[#, 
                    Dynamic[$CellContext`\[Lambda]$$], 
                    "Tooltip"]& ]}, {{{-0.075, 0.}, {0., 0.075}}, {
                    1.1123470522803114` (-0.001 + 1. If[
                    Dynamic[
                    MatchQ[$CellContext`\[Lambda]$$, 
                    PatternTest[
                    Blank[], Charting`realNumericQ]]], 
                    Dynamic[
                    Clip[$CellContext`\[Lambda]$$, 
                    Sort[
                    N[{0.001, 0.9}], Less]]], 0.001]), 0.0375}}]}, {}, 
                  
                  GeometricTransformationBox[{}, {{{1, 0}, {0, 1}}, {0, 
                    0}}]}, {
                 AlignmentPoint -> Center, AspectRatio -> Automatic, Axes -> 
                  False, AxesLabel -> None, AxesOrigin -> Automatic, 
                  AxesStyle -> {}, Background -> None, BaselinePosition -> 
                  Automatic, BaseStyle -> {}, ColorOutput -> Automatic, 
                  ContentSelectable -> Automatic, CoordinatesToolOptions -> 
                  Automatic, DisplayFunction -> Identity, Epilog -> {}, 
                  FormatType -> TraditionalForm, Frame -> False, FrameLabel -> 
                  None, FrameStyle -> {}, FrameTicks -> Automatic, 
                  FrameTicksStyle -> {}, GridLines -> None, 
                  GridLinesStyle -> {}, ImageMargins -> 0., ImagePadding -> 
                  All, ImageSize -> {230, 32}, ImageSizeRaw -> Automatic, 
                  LabelStyle -> {}, 
                  Method -> {
                   "DefaultBoundaryStyle" -> Automatic, 
                    "DefaultGraphicsInteraction" -> {
                    "Version" -> 1.2, "TrackMousePosition" -> {True, False}, 
                    "Effects" -> {
                    "Highlight" -> {"ratio" -> 2}, 
                    "HighlightPoint" -> {"ratio" -> 2}, 
                    "Droplines" -> {
                    "freeformCursorMode" -> True, 
                    "placement" -> {"x" -> "All", "y" -> "None"}}}}, 
                    "DefaultPlotStyle" -> Automatic}, PlotLabel -> None, 
                  PlotRange -> All, PlotRangeClipping -> False, 
                  PlotRangePadding -> Automatic, PlotRegion -> Automatic, 
                  PreserveImageOptions -> Automatic, Prolog -> {}, 
                  RotateLabel -> True, Ticks -> Automatic, TicksStyle -> {}, 
                  Axes -> False, Method -> Automatic}], Appearance -> None, 
                Enabled -> Automatic], DynamicModuleValues :> {}], 
              InputFieldBox[
               Dynamic[
                
                SetAccuracy[$CellContext`\[Lambda]$$, 
                 4], {($CellContext`\[Lambda]$$ = #)& , ($CellContext`\
\[Lambda]$$ = $CellContext`cost[#, {0.001, 0.9, 0.001}]; If[
                   NumericQ[$CellContext`\[Lambda]$$], 
                   $CellContext`c$$["evo"]])& }], Number, 
               FieldSize -> {4, 1}]},
             "RowDefault"]},
           {
            TagBox[
             TooltipBox["\<\"Detection rate:\"\>",
              
              "\"Parameter that describes how fast we detect the infected \
nodes. The bigger, the faster they get detected.\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, 
              "Parameter that describes how fast we detect the infected \
nodes. The bigger, the faster they get detected.", "Tooltip"]& ], 
            TemplateBox[{
              DynamicModuleBox[{System`GaugesDump`height$$ = Dynamic[
                  
                  Charting`barValHeight[$CellContext`o$$, {
                   Identity, Identity}, {0.001, 0.9}, {{0, 0}, {1, 0}}, 0]], 
                System`GaugesDump`pt$$ = {0., 0.}}, 
               LocatorPaneBox[
                Dynamic[
                 
                 Charting`barValueToPoint[$CellContext`o$$, {
                  Identity, Identity}, {0.001, 0.9}, {{0, 0}, {1, 0}}, 0], {
                 None, (System`GaugesDump`height$$ = 
                   Charting`barPointtoValue[#, {Identity, Identity}, {0.001, 
                    0.9}, {{0, 0}, {1, 0}}, 0]; $CellContext`o$$ = (
                    Part[{None, ($CellContext`o$$ = #)& , $CellContext`c$$[
                    "evo"]& }, 2][
                    System`GaugesDump`height$$, #2]; $CellContext`o$$); 
                  System`GaugesDump`pt$$ = 
                   Charting`barValueToPoint[$CellContext`o$$, {
                    Identity, Identity}, {0.001, 0.9}, {{0, 0}, {1, 0}}, 0]; 
                  Null)& , $CellContext`c$$["evo"]& }, {}], 
                GraphicsBox[{{}, {
                   Opacity[0], 
                   PointBox[{{-0.1, 0.}, {1.1, 0.}}]}, 
                  GeometricTransformationBox[{{}}, {{{1, 0}, {0, 1}}, {0, 
                    0}}], {
                   StyleBox[{Antialiasing -> False, 
                    StyleBox[
                    
                    LineBox[{{0., 0.}, {1., 0.}}], {{{}}, StripOnInput -> 
                    False}, StripOnInput -> False], 
                    StyleBox[
                    StyleBox[{{
                    StyleBox[
                    LineBox[{{{0.11012235817575083`, 0.}, 
                    Scaled[{0., 0.06}, {0.11012235817575083`, 0.}]}, {{
                    0.22135706340378197`, 0.}, 
                    Scaled[{0., 0.06}, {0.22135706340378197`, 0.}]}, {{
                    0.3325917686318131, 0.}, 
                    Scaled[{0., 0.06}, {0.3325917686318131, 0.}]}, {{
                    0.44382647385984425`, 0.}, 
                    Scaled[{0., 0.06}, {0.44382647385984425`, 0.}]}, {{
                    0.5550611790878753, 0.}, 
                    Scaled[{0., 0.06}, {0.5550611790878753, 0.}]}, {{
                    0.6662958843159065, 0.}, 
                    Scaled[{0., 0.06}, {0.6662958843159065, 0.}]}, {{
                    0.7775305895439376, 0.}, 
                    Scaled[{0., 0.06}, {0.7775305895439376, 0.}]}, {{
                    0.8887652947719689, 0.}, 
                    Scaled[{0., 0.06}, {0.8887652947719689, 0.}]}, {{1., 0.}, 
                    
                    Scaled[{0., 0.06}, {1., 0.}]}}], {{{}}, StripOnInput -> 
                    False}, StripOnInput -> False], 
                    StyleBox[
                    LineBox[{{{0.010011123470522803`, 0.}, 
                    Scaled[{0., 0.04}, {0.010011123470522803`, 0.}]}, {{
                    0.021134593993325915`, 0.}, 
                    Scaled[{0., 0.04}, {0.021134593993325915`, 0.}]}, {{
                    0.03225806451612903, 0.}, 
                    Scaled[{0., 0.04}, {0.03225806451612903, 0.}]}, {{
                    0.04338153503893214, 0.}, 
                    Scaled[{0., 0.04}, {0.04338153503893214, 0.}]}, {{
                    0.05450500556173526, 0.}, 
                    Scaled[{0., 0.04}, {0.05450500556173526, 0.}]}, {{
                    0.06562847608453837, 0.}, 
                    Scaled[{0., 0.04}, {0.06562847608453837, 0.}]}, {{
                    0.0767519466073415, 0.}, 
                    Scaled[{0., 0.04}, {0.0767519466073415, 0.}]}, {{
                    0.0878754171301446, 0.}, 
                    Scaled[{0., 0.04}, {0.0878754171301446, 0.}]}, {{
                    0.0989988876529477, 0.}, 
                    Scaled[{0., 0.04}, {0.0989988876529477, 0.}]}, {{
                    0.12124582869855394`, 0.}, 
                    Scaled[{0., 0.04}, {0.12124582869855394`, 0.}]}, {{
                    0.13236929922135704`, 0.}, 
                    Scaled[{0., 0.04}, {0.13236929922135704`, 0.}]}, {{
                    0.14349276974416017`, 0.}, 
                    Scaled[{0., 0.04}, {0.14349276974416017`, 0.}]}, {{
                    0.1546162402669633, 0.}, 
                    Scaled[{0., 0.04}, {0.1546162402669633, 0.}]}, {{
                    0.1657397107897664, 0.}, 
                    Scaled[{0., 0.04}, {0.1657397107897664, 0.}]}, {{
                    0.1768631813125695, 0.}, 
                    Scaled[{0., 0.04}, {0.1768631813125695, 0.}]}, {{
                    0.18798665183537264`, 0.}, 
                    Scaled[{0., 0.04}, {0.18798665183537264`, 0.}]}, {{
                    0.19911012235817574`, 0.}, 
                    Scaled[{0., 0.04}, {0.19911012235817574`, 0.}]}, {{
                    0.21023359288097884`, 0.}, 
                    Scaled[{0., 0.04}, {0.21023359288097884`, 0.}]}, {{
                    0.23248053392658508`, 0.}, 
                    Scaled[{0., 0.04}, {0.23248053392658508`, 0.}]}, {{
                    0.2436040044493882, 0.}, 
                    Scaled[{0., 0.04}, {0.2436040044493882, 0.}]}, {{
                    0.25472747497219134`, 0.}, 
                    Scaled[{0., 0.04}, {0.25472747497219134`, 0.}]}, {{
                    0.2658509454949944, 0.}, 
                    Scaled[{0., 0.04}, {0.2658509454949944, 0.}]}, {{
                    0.27697441601779754`, 0.}, 
                    Scaled[{0., 0.04}, {0.27697441601779754`, 0.}]}, {{
                    0.28809788654060065`, 0.}, 
                    Scaled[{0., 0.04}, {0.28809788654060065`, 0.}]}, {{
                    0.2992213570634038, 0.}, 
                    Scaled[{0., 0.04}, {0.2992213570634038, 0.}]}, {{
                    0.3103448275862069, 0.}, 
                    Scaled[{0., 0.04}, {0.3103448275862069, 0.}]}, {{
                    0.32146829810900995`, 0.}, 
                    Scaled[{0., 0.04}, {0.32146829810900995`, 0.}]}, {{
                    0.3437152391546162, 0.}, 
                    Scaled[{0., 0.04}, {0.3437152391546162, 0.}]}, {{
                    0.3548387096774193, 0.}, 
                    Scaled[{0., 0.04}, {0.3548387096774193, 0.}]}, {{
                    0.3659621802002225, 0.}, 
                    Scaled[{0., 0.04}, {0.3659621802002225, 0.}]}, {{
                    0.3770856507230256, 0.}, 
                    Scaled[{0., 0.04}, {0.3770856507230256, 0.}]}, {{
                    0.3882091212458286, 0.}, 
                    Scaled[{0., 0.04}, {0.3882091212458286, 0.}]}, {{
                    0.3993325917686318, 0.}, 
                    Scaled[{0., 0.04}, {0.3993325917686318, 0.}]}, {{
                    0.4104560622914349, 0.}, 
                    Scaled[{0., 0.04}, {0.4104560622914349, 0.}]}, {{
                    0.42157953281423804`, 0.}, 
                    Scaled[{0., 0.04}, {0.42157953281423804`, 0.}]}, {{
                    0.43270300333704115`, 0.}, 
                    Scaled[{0., 0.04}, {0.43270300333704115`, 0.}]}, {{
                    0.45494994438264735`, 0.}, 
                    Scaled[{0., 0.04}, {0.45494994438264735`, 0.}]}, {{
                    0.46607341490545046`, 0.}, 
                    Scaled[{0., 0.04}, {0.46607341490545046`, 0.}]}, {{
                    0.47719688542825356`, 0.}, 
                    Scaled[{0., 0.04}, {0.47719688542825356`, 0.}]}, {{
                    0.4883203559510567, 0.}, 
                    Scaled[{0., 0.04}, {0.4883203559510567, 0.}]}, {{
                    0.4994438264738598, 0.}, 
                    Scaled[{0., 0.04}, {0.4994438264738598, 0.}]}, {{
                    0.5105672969966629, 0.}, 
                    Scaled[{0., 0.04}, {0.5105672969966629, 0.}]}, {{
                    0.521690767519466, 0.}, 
                    Scaled[{0., 0.04}, {0.521690767519466, 0.}]}, {{
                    0.5328142380422691, 0.}, 
                    Scaled[{0., 0.04}, {0.5328142380422691, 0.}]}, {{
                    0.5439377085650723, 0.}, 
                    Scaled[{0., 0.04}, {0.5439377085650723, 0.}]}, {{
                    0.5661846496106785, 0.}, 
                    Scaled[{0., 0.04}, {0.5661846496106785, 0.}]}, {{
                    0.5773081201334817, 0.}, 
                    Scaled[{0., 0.04}, {0.5773081201334817, 0.}]}, {{
                    0.5884315906562847, 0.}, 
                    Scaled[{0., 0.04}, {0.5884315906562847, 0.}]}, {{
                    0.5995550611790879, 0.}, 
                    Scaled[{0., 0.04}, {0.5995550611790879, 0.}]}, {{
                    0.610678531701891, 0.}, 
                    Scaled[{0., 0.04}, {0.610678531701891, 0.}]}, {{
                    0.6218020022246942, 0.}, 
                    Scaled[{0., 0.04}, {0.6218020022246942, 0.}]}, {{
                    0.6329254727474971, 0.}, 
                    Scaled[{0., 0.04}, {0.6329254727474971, 0.}]}, {{
                    0.6440489432703003, 0.}, 
                    Scaled[{0., 0.04}, {0.6440489432703003, 0.}]}, {{
                    0.6551724137931034, 0.}, 
                    Scaled[{0., 0.04}, {0.6551724137931034, 0.}]}, {{
                    0.6774193548387096, 0.}, 
                    Scaled[{0., 0.04}, {0.6774193548387096, 0.}]}, {{
                    0.6885428253615128, 0.}, 
                    Scaled[{0., 0.04}, {0.6885428253615128, 0.}]}, {{
                    0.6996662958843158, 0.}, 
                    Scaled[{0., 0.04}, {0.6996662958843158, 0.}]}, {{
                    0.710789766407119, 0.}, 
                    Scaled[{0., 0.04}, {0.710789766407119, 0.}]}, {{
                    0.7219132369299222, 0.}, 
                    Scaled[{0., 0.04}, {0.7219132369299222, 0.}]}, {{
                    0.7330367074527252, 0.}, 
                    Scaled[{0., 0.04}, {0.7330367074527252, 0.}]}, {{
                    0.7441601779755284, 0.}, 
                    Scaled[{0., 0.04}, {0.7441601779755284, 0.}]}, {{
                    0.7552836484983315, 0.}, 
                    Scaled[{0., 0.04}, {0.7552836484983315, 0.}]}, {{
                    0.7664071190211345, 0.}, 
                    Scaled[{0., 0.04}, {0.7664071190211345, 0.}]}, {{
                    0.7886540600667408, 0.}, 
                    Scaled[{0., 0.04}, {0.7886540600667408, 0.}]}, {{
                    0.7997775305895438, 0.}, 
                    Scaled[{0., 0.04}, {0.7997775305895438, 0.}]}, {{
                    0.810901001112347, 0.}, 
                    Scaled[{0., 0.04}, {0.810901001112347, 0.}]}, {{
                    0.8220244716351501, 0.}, 
                    Scaled[{0., 0.04}, {0.8220244716351501, 0.}]}, {{
                    0.8331479421579532, 0.}, 
                    Scaled[{0., 0.04}, {0.8331479421579532, 0.}]}, {{
                    0.8442714126807563, 0.}, 
                    Scaled[{0., 0.04}, {0.8442714126807563, 0.}]}, {{
                    0.8553948832035595, 0.}, 
                    Scaled[{0., 0.04}, {0.8553948832035595, 0.}]}, {{
                    0.8665183537263625, 0.}, 
                    Scaled[{0., 0.04}, {0.8665183537263625, 0.}]}, {{
                    0.8776418242491657, 0.}, 
                    Scaled[{0., 0.04}, {0.8776418242491657, 0.}]}, {{
                    0.899888765294772, 0.}, 
                    Scaled[{0., 0.04}, {0.899888765294772, 0.}]}, {{
                    0.911012235817575, 0.}, 
                    Scaled[{0., 0.04}, {0.911012235817575, 0.}]}, {{
                    0.9221357063403781, 0.}, 
                    Scaled[{0., 0.04}, {0.9221357063403781, 0.}]}, {{
                    0.9332591768631813, 0.}, 
                    Scaled[{0., 0.04}, {0.9332591768631813, 0.}]}, {{
                    0.9443826473859843, 0.}, 
                    Scaled[{0., 0.04}, {0.9443826473859843, 0.}]}, {{
                    0.9555061179087875, 0.}, 
                    Scaled[{0., 0.04}, {0.9555061179087875, 0.}]}, {{
                    0.9666295884315906, 0.}, 
                    Scaled[{0., 0.04}, {0.9666295884315906, 0.}]}, {{
                    0.9777530589543937, 0.}, 
                    Scaled[{0., 0.04}, {0.9777530589543937, 0.}]}, {{
                    0.9888765294771968, 0.}, 
                    Scaled[{0., 0.04}, {0.9888765294771968, 0.}]}}], {{{}}, 
                    StripOnInput -> False}, StripOnInput -> False]}, 
                    StyleBox[
                    StyleBox[{{
                    StyleBox[{
                    InsetBox[
                    BoxData[
                    FormBox["0.1`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.11012235817575083`, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.2`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.22135706340378197`, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.3`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.3325917686318131, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.4`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.44382647385984425`, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.5`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.5550611790878753, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.6`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.6662958843159065, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.7`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.7775305895439376, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.8`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.8887652947719689, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.9`", TraditionalForm]], 
                    Offset[{0., -3.}, {1., 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 
                    0}]}, {{{}, {{}, {}}}, StripOnInput -> False}, 
                    StripOnInput -> False], 
                    
                    StyleBox[{{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}, {{{}, {{}, {}}}, 
                    StripOnInput -> False}, StripOnInput -> 
                    False]}, {}}, {{{}}, StripOnInput -> False}, StripOnInput -> 
                    False], {{{
                    GrayLevel[0.25], FontSize -> 10, FontFamily -> 
                    "Helvetica"}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {{{
                    Directive[
                    CapForm["Butt"], 
                    AbsoluteThickness[1], 
                    GrayLevel[0.5]], 
                    Directive[
                    CapForm["Butt"], 
                    AbsoluteThickness[0.5], 
                    GrayLevel[0.5]]}}, StripOnInput -> False}, StripOnInput -> 
                    False], {{{}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {{
                    Directive[
                    AbsoluteThickness[1], 
                    GrayLevel[0.5]]}, StripOnInput -> False}, StripOnInput -> 
                    False], {}}, {}, {
                   Directive[
                    RGBColor[1, 0.6666666666666666, 
                    NCache[
                    Rational[1, 3], 0.3333333333333333]]], 
                   GeometricTransformationBox[{{}, 
                    Directive[
                    RGBColor[1, 0.6666666666666666, 
                    NCache[
                    Rational[1, 3], 0.3333333333333333]]], {}, 
                    "MarkerRotation" -> 0, 
                    TagBox[
                    TooltipBox[
                    PolygonBox[{{0.5, 0.5}, {-0.5, 0.5}, {0., -0.5}}], 
                    DynamicBox[
                    ToBoxes[$CellContext`o$$, StandardForm]]], Annotation[#, 
                    Dynamic[$CellContext`o$$], "Tooltip"]& ]}, {{{-0.075, 
                    0.}, {0., 0.075}}, {1.1123470522803114` (-0.001 + 1. If[
                    Dynamic[
                    MatchQ[$CellContext`o$$, 
                    PatternTest[
                    Blank[], Charting`realNumericQ]]], 
                    Dynamic[
                    Clip[$CellContext`o$$, 
                    Sort[
                    N[{0.001, 0.9}], Less]]], 0.001]), 0.0375}}]}, {}, 
                  
                  GeometricTransformationBox[{}, {{{1, 0}, {0, 1}}, {0, 
                    0}}]}, {
                 AlignmentPoint -> Center, AspectRatio -> Automatic, Axes -> 
                  False, AxesLabel -> None, AxesOrigin -> Automatic, 
                  AxesStyle -> {}, Background -> None, BaselinePosition -> 
                  Automatic, BaseStyle -> {}, ColorOutput -> Automatic, 
                  ContentSelectable -> Automatic, CoordinatesToolOptions -> 
                  Automatic, DisplayFunction -> Identity, Epilog -> {}, 
                  FormatType -> TraditionalForm, Frame -> False, FrameLabel -> 
                  None, FrameStyle -> {}, FrameTicks -> Automatic, 
                  FrameTicksStyle -> {}, GridLines -> None, 
                  GridLinesStyle -> {}, ImageMargins -> 0., ImagePadding -> 
                  All, ImageSize -> {230, 32}, ImageSizeRaw -> Automatic, 
                  LabelStyle -> {}, 
                  Method -> {
                   "DefaultBoundaryStyle" -> Automatic, 
                    "DefaultGraphicsInteraction" -> {
                    "Version" -> 1.2, "TrackMousePosition" -> {True, False}, 
                    "Effects" -> {
                    "Highlight" -> {"ratio" -> 2}, 
                    "HighlightPoint" -> {"ratio" -> 2}, 
                    "Droplines" -> {
                    "freeformCursorMode" -> True, 
                    "placement" -> {"x" -> "All", "y" -> "None"}}}}, 
                    "DefaultPlotStyle" -> Automatic}, PlotLabel -> None, 
                  PlotRange -> All, PlotRangeClipping -> False, 
                  PlotRangePadding -> Automatic, PlotRegion -> Automatic, 
                  PreserveImageOptions -> Automatic, Prolog -> {}, 
                  RotateLabel -> True, Ticks -> Automatic, TicksStyle -> {}, 
                  Axes -> False, Method -> Automatic}], Appearance -> None, 
                Enabled -> Automatic], DynamicModuleValues :> {}], 
              InputFieldBox[
               Dynamic[
                
                SetAccuracy[$CellContext`o$$, 
                 4], {($CellContext`o$$ = #)& , ($CellContext`o$$ = \
$CellContext`cost[#, {0.001, 0.9, 0.001}]; If[
                   NumericQ[$CellContext`o$$], 
                   $CellContext`c$$["evo"]])& }], Number, 
               FieldSize -> {4, 1}]},
             "RowDefault"]},
           {
            TagBox[
             TooltipBox["\<\"Recovery rate:\"\>",
              
              "\"Parameter that describes how fast the infected can recover. \
The bigger, the faster they can recover.\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, 
              "Parameter that describes how fast the infected can recover. \
The bigger, the faster they can recover.", "Tooltip"]& ], 
            TemplateBox[{
              DynamicModuleBox[{System`GaugesDump`height$$ = Dynamic[
                  
                  Charting`barValHeight[$CellContext`g$$, {
                   Identity, Identity}, {0.001, 0.3}, {{0, 0}, {1, 0}}, 0]], 
                System`GaugesDump`pt$$ = {0., 0.}}, 
               LocatorPaneBox[
                Dynamic[
                 
                 Charting`barValueToPoint[$CellContext`g$$, {
                  Identity, Identity}, {0.001, 0.3}, {{0, 0}, {1, 0}}, 0], {
                 None, (System`GaugesDump`height$$ = 
                   Charting`barPointtoValue[#, {Identity, Identity}, {0.001, 
                    0.3}, {{0, 0}, {1, 0}}, 0]; $CellContext`g$$ = (
                    Part[{None, ($CellContext`g$$ = #)& , $CellContext`c$$[
                    "evo"]& }, 2][
                    System`GaugesDump`height$$, #2]; $CellContext`g$$); 
                  System`GaugesDump`pt$$ = 
                   Charting`barValueToPoint[$CellContext`g$$, {
                    Identity, Identity}, {0.001, 0.3}, {{0, 0}, {1, 0}}, 0]; 
                  Null)& , $CellContext`c$$["evo"]& }, {}], 
                GraphicsBox[{{}, {
                   Opacity[0], 
                   PointBox[{{-0.1, 0.}, {1.1, 0.}}]}, 
                  
                  GeometricTransformationBox[{{}}, {{{1, 0}, {0, 1}}, {0, 
                    0}}], {
                   StyleBox[{Antialiasing -> False, 
                    StyleBox[
                    
                    LineBox[{{0., 0.}, {1., 0.}}], {{{}}, StripOnInput -> 
                    False}, StripOnInput -> False], 
                    StyleBox[
                    StyleBox[{{
                    StyleBox[
                    LineBox[{{{0.16387959866220736`, 0.}, 
                    Scaled[{0., 0.06}, {0.16387959866220736`, 0.}]}, {{
                    0.3311036789297659, 0.}, 
                    Scaled[{0., 0.06}, {0.3311036789297659, 0.}]}, {{
                    0.4983277591973244, 0.}, 
                    Scaled[{0., 0.06}, {0.4983277591973244, 0.}]}, {{
                    0.6655518394648829, 0.}, 
                    Scaled[{0., 0.06}, {0.6655518394648829, 0.}]}, {{
                    0.8327759197324415, 0.}, 
                    Scaled[{0., 0.06}, {0.8327759197324415, 0.}]}, {{1., 0.}, 
                    
                    Scaled[{0., 0.06}, {1., 0.}]}}], {{{}}, StripOnInput -> 
                    False}, StripOnInput -> False], 
                    StyleBox[
                    LineBox[{{{0.013377926421404682`, 0.}, 
                    Scaled[{0., 0.04}, {0.013377926421404682`, 0.}]}, {{
                    0.03010033444816054, 0.}, 
                    Scaled[{0., 0.04}, {0.03010033444816054, 0.}]}, {{
                    0.046822742474916385`, 0.}, 
                    Scaled[{0., 0.04}, {0.046822742474916385`, 0.}]}, {{
                    0.06354515050167224, 0.}, 
                    Scaled[{0., 0.04}, {0.06354515050167224, 0.}]}, {{
                    0.0802675585284281, 0.}, 
                    Scaled[{0., 0.04}, {0.0802675585284281, 0.}]}, {{
                    0.09698996655518394, 0.}, 
                    Scaled[{0., 0.04}, {0.09698996655518394, 0.}]}, {{
                    0.1137123745819398, 0.}, 
                    Scaled[{0., 0.04}, {0.1137123745819398, 0.}]}, {{
                    0.13043478260869565`, 0.}, 
                    Scaled[{0., 0.04}, {0.13043478260869565`, 0.}]}, {{
                    0.1471571906354515, 0.}, 
                    Scaled[{0., 0.04}, {0.1471571906354515, 0.}]}, {{
                    0.1806020066889632, 0.}, 
                    Scaled[{0., 0.04}, {0.1806020066889632, 0.}]}, {{
                    0.19732441471571904`, 0.}, 
                    Scaled[{0., 0.04}, {0.19732441471571904`, 0.}]}, {{
                    0.2140468227424749, 0.}, 
                    Scaled[{0., 0.04}, {0.2140468227424749, 0.}]}, {{
                    0.23076923076923078`, 0.}, 
                    Scaled[{0., 0.04}, {0.23076923076923078`, 0.}]}, {{
                    0.2474916387959866, 0.}, 
                    Scaled[{0., 0.04}, {0.2474916387959866, 0.}]}, {{
                    0.26421404682274247`, 0.}, 
                    Scaled[{0., 0.04}, {0.26421404682274247`, 0.}]}, {{
                    0.28093645484949836`, 0.}, 
                    Scaled[{0., 0.04}, {0.28093645484949836`, 0.}]}, {{
                    0.29765886287625415`, 0.}, 
                    Scaled[{0., 0.04}, {0.29765886287625415`, 0.}]}, {{
                    0.31438127090301005`, 0.}, 
                    Scaled[{0., 0.04}, {0.31438127090301005`, 0.}]}, {{
                    0.34782608695652173`, 0.}, 
                    Scaled[{0., 0.04}, {0.34782608695652173`, 0.}]}, {{
                    0.36454849498327757`, 0.}, 
                    Scaled[{0., 0.04}, {0.36454849498327757`, 0.}]}, {{
                    0.38127090301003347`, 0.}, 
                    Scaled[{0., 0.04}, {0.38127090301003347`, 0.}]}, {{
                    0.39799331103678925`, 0.}, 
                    Scaled[{0., 0.04}, {0.39799331103678925`, 0.}]}, {{
                    0.41471571906354515`, 0.}, 
                    Scaled[{0., 0.04}, {0.41471571906354515`, 0.}]}, {{
                    0.431438127090301, 0.}, 
                    Scaled[{0., 0.04}, {0.431438127090301, 0.}]}, {{
                    0.4481605351170569, 0.}, 
                    Scaled[{0., 0.04}, {0.4481605351170569, 0.}]}, {{
                    0.46488294314381273`, 0.}, 
                    Scaled[{0., 0.04}, {0.46488294314381273`, 0.}]}, {{
                    0.4816053511705685, 0.}, 
                    Scaled[{0., 0.04}, {0.4816053511705685, 0.}]}, {{
                    0.5150501672240803, 0.}, 
                    Scaled[{0., 0.04}, {0.5150501672240803, 0.}]}, {{
                    0.5317725752508361, 0.}, 
                    Scaled[{0., 0.04}, {0.5317725752508361, 0.}]}, {{
                    0.5484949832775919, 0.}, 
                    Scaled[{0., 0.04}, {0.5484949832775919, 0.}]}, {{
                    0.5652173913043479, 0.}, 
                    Scaled[{0., 0.04}, {0.5652173913043479, 0.}]}, {{
                    0.5819397993311036, 0.}, 
                    Scaled[{0., 0.04}, {0.5819397993311036, 0.}]}, {{
                    0.5986622073578595, 0.}, 
                    Scaled[{0., 0.04}, {0.5986622073578595, 0.}]}, {{
                    0.6153846153846154, 0.}, 
                    Scaled[{0., 0.04}, {0.6153846153846154, 0.}]}, {{
                    0.6321070234113713, 0.}, 
                    Scaled[{0., 0.04}, {0.6321070234113713, 0.}]}, {{
                    0.6488294314381271, 0.}, 
                    Scaled[{0., 0.04}, {0.6488294314381271, 0.}]}, {{
                    0.6822742474916388, 0.}, 
                    Scaled[{0., 0.04}, {0.6822742474916388, 0.}]}, {{
                    0.6989966555183946, 0.}, 
                    Scaled[{0., 0.04}, {0.6989966555183946, 0.}]}, {{
                    0.7157190635451505, 0.}, 
                    Scaled[{0., 0.04}, {0.7157190635451505, 0.}]}, {{
                    0.7324414715719063, 0.}, 
                    Scaled[{0., 0.04}, {0.7324414715719063, 0.}]}, {{
                    0.7491638795986623, 0.}, 
                    Scaled[{0., 0.04}, {0.7491638795986623, 0.}]}, {{
                    0.7658862876254181, 0.}, 
                    Scaled[{0., 0.04}, {0.7658862876254181, 0.}]}, {{
                    0.7826086956521738, 0.}, 
                    Scaled[{0., 0.04}, {0.7826086956521738, 0.}]}, {{
                    0.7993311036789297, 0.}, 
                    Scaled[{0., 0.04}, {0.7993311036789297, 0.}]}, {{
                    0.8160535117056856, 0.}, 
                    Scaled[{0., 0.04}, {0.8160535117056856, 0.}]}, {{
                    0.8494983277591973, 0.}, 
                    Scaled[{0., 0.04}, {0.8494983277591973, 0.}]}, {{
                    0.8662207357859532, 0.}, 
                    Scaled[{0., 0.04}, {0.8662207357859532, 0.}]}, {{
                    0.8829431438127091, 0.}, 
                    Scaled[{0., 0.04}, {0.8829431438127091, 0.}]}, {{
                    0.899665551839465, 0.}, 
                    Scaled[{0., 0.04}, {0.899665551839465, 0.}]}, {{
                    0.9163879598662208, 0.}, 
                    Scaled[{0., 0.04}, {0.9163879598662208, 0.}]}, {{
                    0.9331103678929766, 0.}, 
                    Scaled[{0., 0.04}, {0.9331103678929766, 0.}]}, {{
                    0.9498327759197324, 0.}, 
                    Scaled[{0., 0.04}, {0.9498327759197324, 0.}]}, {{
                    0.9665551839464882, 0.}, 
                    Scaled[{0., 0.04}, {0.9665551839464882, 0.}]}, {{
                    0.983277591973244, 0.}, 
                    Scaled[{0., 0.04}, {0.983277591973244, 0.}]}}], {{{}}, 
                    StripOnInput -> False}, StripOnInput -> False]}, 
                    StyleBox[
                    StyleBox[{{
                    StyleBox[{
                    InsetBox[
                    BoxData[
                    FormBox["0.05`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.16387959866220736`, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.1`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.3311036789297659, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.15`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.4983277591973244, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.2`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.6655518394648829, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.25`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.8327759197324415, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.3`", TraditionalForm]], 
                    Offset[{0., -3.}, {1., 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 
                    0}]}, {{{}, {{}, {}}}, StripOnInput -> False}, 
                    StripOnInput -> False], 
                    
                    StyleBox[{{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}}, {{{}, {{}, {}}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {}}, {{{}}, StripOnInput -> False}, StripOnInput -> 
                    False], {{{
                    GrayLevel[0.25], FontSize -> 10, FontFamily -> 
                    "Helvetica"}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {{{
                    Directive[
                    CapForm["Butt"], 
                    AbsoluteThickness[1], 
                    GrayLevel[0.5]], 
                    Directive[
                    CapForm["Butt"], 
                    AbsoluteThickness[0.5], 
                    GrayLevel[0.5]]}}, StripOnInput -> False}, StripOnInput -> 
                    False], {{{}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {{
                    Directive[
                    AbsoluteThickness[1], 
                    GrayLevel[0.5]]}, StripOnInput -> False}, StripOnInput -> 
                    False], {}}, {}, {
                   Directive[
                    RGBColor[0.54, 1., 0.94]], 
                   GeometricTransformationBox[{{}, 
                    Directive[
                    RGBColor[0.54, 1., 0.94]], {}, "MarkerRotation" -> 0, 
                    TagBox[
                    TooltipBox[
                    PolygonBox[{{0.5, 0.5}, {-0.5, 0.5}, {0., -0.5}}], 
                    DynamicBox[
                    ToBoxes[$CellContext`g$$, StandardForm]]], Annotation[#, 
                    Dynamic[$CellContext`g$$], "Tooltip"]& ]}, {{{-0.075, 
                    0.}, {0., 0.075}}, {3.3444816053511706` (-0.001 + 1. If[
                    Dynamic[
                    MatchQ[$CellContext`g$$, 
                    PatternTest[
                    Blank[], Charting`realNumericQ]]], 
                    Dynamic[
                    Clip[$CellContext`g$$, 
                    Sort[
                    N[{0.001, 0.3}], Less]]], 0.001]), 0.0375}}]}, {}, 
                  
                  GeometricTransformationBox[{}, {{{1, 0}, {0, 1}}, {0, 
                    0}}]}, {
                 AlignmentPoint -> Center, AspectRatio -> Automatic, Axes -> 
                  False, AxesLabel -> None, AxesOrigin -> Automatic, 
                  AxesStyle -> {}, Background -> None, BaselinePosition -> 
                  Automatic, BaseStyle -> {}, ColorOutput -> Automatic, 
                  ContentSelectable -> Automatic, CoordinatesToolOptions -> 
                  Automatic, DisplayFunction -> Identity, Epilog -> {}, 
                  FormatType -> TraditionalForm, Frame -> False, FrameLabel -> 
                  None, FrameStyle -> {}, FrameTicks -> Automatic, 
                  FrameTicksStyle -> {}, GridLines -> None, 
                  GridLinesStyle -> {}, ImageMargins -> 0., ImagePadding -> 
                  All, ImageSize -> {230, 32}, ImageSizeRaw -> Automatic, 
                  LabelStyle -> {}, 
                  Method -> {
                   "DefaultBoundaryStyle" -> Automatic, 
                    "DefaultGraphicsInteraction" -> {
                    "Version" -> 1.2, "TrackMousePosition" -> {True, False}, 
                    "Effects" -> {
                    "Highlight" -> {"ratio" -> 2}, 
                    "HighlightPoint" -> {"ratio" -> 2}, 
                    "Droplines" -> {
                    "freeformCursorMode" -> True, 
                    "placement" -> {"x" -> "All", "y" -> "None"}}}}, 
                    "DefaultPlotStyle" -> Automatic}, PlotLabel -> None, 
                  PlotRange -> All, PlotRangeClipping -> False, 
                  PlotRangePadding -> Automatic, PlotRegion -> Automatic, 
                  PreserveImageOptions -> Automatic, Prolog -> {}, 
                  RotateLabel -> True, Ticks -> Automatic, TicksStyle -> {}, 
                  Axes -> False, Method -> Automatic}], Appearance -> None, 
                Enabled -> Automatic], DynamicModuleValues :> {}], 
              InputFieldBox[
               Dynamic[
                
                SetAccuracy[$CellContext`g$$, 
                 4], {($CellContext`g$$ = #)& , ($CellContext`g$$ = \
$CellContext`cost[#, {0.001, 0.3, 0.001}]; If[
                   NumericQ[$CellContext`g$$], 
                   $CellContext`c$$["evo"]])& }], Number, 
               FieldSize -> {4, 1}]},
             "RowDefault"]},
           {
            TagBox[
             TooltipBox["\<\"Death rate:\"\>",
              
              "\"Parameter that describes how fast the infected can die. The \
bigger, the faster they can die.\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, 
              "Parameter that describes how fast the infected can die. The \
bigger, the faster they can die.", "Tooltip"]& ], 
            TemplateBox[{
              DynamicModuleBox[{System`GaugesDump`height$$ = Dynamic[
                  
                  Charting`barValHeight[$CellContext`d$$, {
                   Identity, Identity}, {0.001, 0.3}, {{0, 0}, {1, 0}}, 0]], 
                System`GaugesDump`pt$$ = {0., 0.}}, 
               LocatorPaneBox[
                Dynamic[
                 
                 Charting`barValueToPoint[$CellContext`d$$, {
                  Identity, Identity}, {0.001, 0.3}, {{0, 0}, {1, 0}}, 0], {
                 None, (System`GaugesDump`height$$ = 
                   Charting`barPointtoValue[#, {Identity, Identity}, {0.001, 
                    0.3}, {{0, 0}, {1, 0}}, 0]; $CellContext`d$$ = (
                    Part[{None, ($CellContext`d$$ = #)& , $CellContext`c$$[
                    "evo"]& }, 2][
                    System`GaugesDump`height$$, #2]; $CellContext`d$$); 
                  System`GaugesDump`pt$$ = 
                   Charting`barValueToPoint[$CellContext`d$$, {
                    Identity, Identity}, {0.001, 0.3}, {{0, 0}, {1, 0}}, 0]; 
                  Null)& , $CellContext`c$$["evo"]& }, {}], 
                GraphicsBox[{{}, {
                   Opacity[0], 
                   PointBox[{{-0.1, 0.}, {1.1, 0.}}]}, 
                  
                  GeometricTransformationBox[{{}}, {{{1, 0}, {0, 1}}, {0, 
                    0}}], {
                   StyleBox[{Antialiasing -> False, 
                    StyleBox[
                    
                    LineBox[{{0., 0.}, {1., 0.}}], {{{}}, StripOnInput -> 
                    False}, StripOnInput -> False], 
                    StyleBox[
                    StyleBox[{{
                    StyleBox[
                    LineBox[{{{0.16387959866220736`, 0.}, 
                    Scaled[{0., 0.06}, {0.16387959866220736`, 0.}]}, {{
                    0.3311036789297659, 0.}, 
                    Scaled[{0., 0.06}, {0.3311036789297659, 0.}]}, {{
                    0.4983277591973244, 0.}, 
                    Scaled[{0., 0.06}, {0.4983277591973244, 0.}]}, {{
                    0.6655518394648829, 0.}, 
                    Scaled[{0., 0.06}, {0.6655518394648829, 0.}]}, {{
                    0.8327759197324415, 0.}, 
                    Scaled[{0., 0.06}, {0.8327759197324415, 0.}]}, {{1., 0.}, 
                    
                    Scaled[{0., 0.06}, {1., 0.}]}}], {{{}}, StripOnInput -> 
                    False}, StripOnInput -> False], 
                    StyleBox[
                    LineBox[{{{0.013377926421404682`, 0.}, 
                    Scaled[{0., 0.04}, {0.013377926421404682`, 0.}]}, {{
                    0.03010033444816054, 0.}, 
                    Scaled[{0., 0.04}, {0.03010033444816054, 0.}]}, {{
                    0.046822742474916385`, 0.}, 
                    Scaled[{0., 0.04}, {0.046822742474916385`, 0.}]}, {{
                    0.06354515050167224, 0.}, 
                    Scaled[{0., 0.04}, {0.06354515050167224, 0.}]}, {{
                    0.0802675585284281, 0.}, 
                    Scaled[{0., 0.04}, {0.0802675585284281, 0.}]}, {{
                    0.09698996655518394, 0.}, 
                    Scaled[{0., 0.04}, {0.09698996655518394, 0.}]}, {{
                    0.1137123745819398, 0.}, 
                    Scaled[{0., 0.04}, {0.1137123745819398, 0.}]}, {{
                    0.13043478260869565`, 0.}, 
                    Scaled[{0., 0.04}, {0.13043478260869565`, 0.}]}, {{
                    0.1471571906354515, 0.}, 
                    Scaled[{0., 0.04}, {0.1471571906354515, 0.}]}, {{
                    0.1806020066889632, 0.}, 
                    Scaled[{0., 0.04}, {0.1806020066889632, 0.}]}, {{
                    0.19732441471571904`, 0.}, 
                    Scaled[{0., 0.04}, {0.19732441471571904`, 0.}]}, {{
                    0.2140468227424749, 0.}, 
                    Scaled[{0., 0.04}, {0.2140468227424749, 0.}]}, {{
                    0.23076923076923078`, 0.}, 
                    Scaled[{0., 0.04}, {0.23076923076923078`, 0.}]}, {{
                    0.2474916387959866, 0.}, 
                    Scaled[{0., 0.04}, {0.2474916387959866, 0.}]}, {{
                    0.26421404682274247`, 0.}, 
                    Scaled[{0., 0.04}, {0.26421404682274247`, 0.}]}, {{
                    0.28093645484949836`, 0.}, 
                    Scaled[{0., 0.04}, {0.28093645484949836`, 0.}]}, {{
                    0.29765886287625415`, 0.}, 
                    Scaled[{0., 0.04}, {0.29765886287625415`, 0.}]}, {{
                    0.31438127090301005`, 0.}, 
                    Scaled[{0., 0.04}, {0.31438127090301005`, 0.}]}, {{
                    0.34782608695652173`, 0.}, 
                    Scaled[{0., 0.04}, {0.34782608695652173`, 0.}]}, {{
                    0.36454849498327757`, 0.}, 
                    Scaled[{0., 0.04}, {0.36454849498327757`, 0.}]}, {{
                    0.38127090301003347`, 0.}, 
                    Scaled[{0., 0.04}, {0.38127090301003347`, 0.}]}, {{
                    0.39799331103678925`, 0.}, 
                    Scaled[{0., 0.04}, {0.39799331103678925`, 0.}]}, {{
                    0.41471571906354515`, 0.}, 
                    Scaled[{0., 0.04}, {0.41471571906354515`, 0.}]}, {{
                    0.431438127090301, 0.}, 
                    Scaled[{0., 0.04}, {0.431438127090301, 0.}]}, {{
                    0.4481605351170569, 0.}, 
                    Scaled[{0., 0.04}, {0.4481605351170569, 0.}]}, {{
                    0.46488294314381273`, 0.}, 
                    Scaled[{0., 0.04}, {0.46488294314381273`, 0.}]}, {{
                    0.4816053511705685, 0.}, 
                    Scaled[{0., 0.04}, {0.4816053511705685, 0.}]}, {{
                    0.5150501672240803, 0.}, 
                    Scaled[{0., 0.04}, {0.5150501672240803, 0.}]}, {{
                    0.5317725752508361, 0.}, 
                    Scaled[{0., 0.04}, {0.5317725752508361, 0.}]}, {{
                    0.5484949832775919, 0.}, 
                    Scaled[{0., 0.04}, {0.5484949832775919, 0.}]}, {{
                    0.5652173913043479, 0.}, 
                    Scaled[{0., 0.04}, {0.5652173913043479, 0.}]}, {{
                    0.5819397993311036, 0.}, 
                    Scaled[{0., 0.04}, {0.5819397993311036, 0.}]}, {{
                    0.5986622073578595, 0.}, 
                    Scaled[{0., 0.04}, {0.5986622073578595, 0.}]}, {{
                    0.6153846153846154, 0.}, 
                    Scaled[{0., 0.04}, {0.6153846153846154, 0.}]}, {{
                    0.6321070234113713, 0.}, 
                    Scaled[{0., 0.04}, {0.6321070234113713, 0.}]}, {{
                    0.6488294314381271, 0.}, 
                    Scaled[{0., 0.04}, {0.6488294314381271, 0.}]}, {{
                    0.6822742474916388, 0.}, 
                    Scaled[{0., 0.04}, {0.6822742474916388, 0.}]}, {{
                    0.6989966555183946, 0.}, 
                    Scaled[{0., 0.04}, {0.6989966555183946, 0.}]}, {{
                    0.7157190635451505, 0.}, 
                    Scaled[{0., 0.04}, {0.7157190635451505, 0.}]}, {{
                    0.7324414715719063, 0.}, 
                    Scaled[{0., 0.04}, {0.7324414715719063, 0.}]}, {{
                    0.7491638795986623, 0.}, 
                    Scaled[{0., 0.04}, {0.7491638795986623, 0.}]}, {{
                    0.7658862876254181, 0.}, 
                    Scaled[{0., 0.04}, {0.7658862876254181, 0.}]}, {{
                    0.7826086956521738, 0.}, 
                    Scaled[{0., 0.04}, {0.7826086956521738, 0.}]}, {{
                    0.7993311036789297, 0.}, 
                    Scaled[{0., 0.04}, {0.7993311036789297, 0.}]}, {{
                    0.8160535117056856, 0.}, 
                    Scaled[{0., 0.04}, {0.8160535117056856, 0.}]}, {{
                    0.8494983277591973, 0.}, 
                    Scaled[{0., 0.04}, {0.8494983277591973, 0.}]}, {{
                    0.8662207357859532, 0.}, 
                    Scaled[{0., 0.04}, {0.8662207357859532, 0.}]}, {{
                    0.8829431438127091, 0.}, 
                    Scaled[{0., 0.04}, {0.8829431438127091, 0.}]}, {{
                    0.899665551839465, 0.}, 
                    Scaled[{0., 0.04}, {0.899665551839465, 0.}]}, {{
                    0.9163879598662208, 0.}, 
                    Scaled[{0., 0.04}, {0.9163879598662208, 0.}]}, {{
                    0.9331103678929766, 0.}, 
                    Scaled[{0., 0.04}, {0.9331103678929766, 0.}]}, {{
                    0.9498327759197324, 0.}, 
                    Scaled[{0., 0.04}, {0.9498327759197324, 0.}]}, {{
                    0.9665551839464882, 0.}, 
                    Scaled[{0., 0.04}, {0.9665551839464882, 0.}]}, {{
                    0.983277591973244, 0.}, 
                    Scaled[{0., 0.04}, {0.983277591973244, 0.}]}}], {{{}}, 
                    StripOnInput -> False}, StripOnInput -> False]}, 
                    StyleBox[
                    StyleBox[{{
                    StyleBox[{
                    InsetBox[
                    BoxData[
                    FormBox["0.05`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.16387959866220736`, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.1`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.3311036789297659, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.15`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.4983277591973244, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.2`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.6655518394648829, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.25`", TraditionalForm]], 
                    Offset[{0., -3.}, {0.8327759197324415, 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 0}], 
                    InsetBox[
                    BoxData[
                    FormBox["0.3`", TraditionalForm]], 
                    Offset[{0., -3.}, {1., 0.}], 
                    ImageScaled[{0.5, 1.}], Automatic, {1, 
                    0}]}, {{{}, {{}, {}}}, StripOnInput -> False}, 
                    StripOnInput -> False], 
                    
                    StyleBox[{{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, \
{}, {}, {}, {}}, {{{}, {{}, {}}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {}}, {{{}}, StripOnInput -> False}, StripOnInput -> 
                    False], {{{
                    GrayLevel[0.25], FontSize -> 10, FontFamily -> 
                    "Helvetica"}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {{{
                    Directive[
                    CapForm["Butt"], 
                    AbsoluteThickness[1], 
                    GrayLevel[0.5]], 
                    Directive[
                    CapForm["Butt"], 
                    AbsoluteThickness[0.5], 
                    GrayLevel[0.5]]}}, StripOnInput -> False}, StripOnInput -> 
                    False], {{{}}, StripOnInput -> False}, StripOnInput -> 
                    False]}, {{
                    Directive[
                    AbsoluteThickness[1], 
                    GrayLevel[0.5]]}, StripOnInput -> False}, StripOnInput -> 
                    False], {}}, {}, {
                   Directive[
                    GrayLevel[0]], 
                   GeometricTransformationBox[{{}, 
                    Directive[
                    GrayLevel[0]], {}, "MarkerRotation" -> 0, 
                    TagBox[
                    TooltipBox[
                    PolygonBox[{{0.5, 0.5}, {-0.5, 0.5}, {0., -0.5}}], 
                    DynamicBox[
                    ToBoxes[$CellContext`d$$, StandardForm]]], Annotation[#, 
                    Dynamic[$CellContext`d$$], "Tooltip"]& ]}, {{{-0.075, 
                    0.}, {0., 0.075}}, {3.3444816053511706` (-0.001 + 1. If[
                    Dynamic[
                    MatchQ[$CellContext`d$$, 
                    PatternTest[
                    Blank[], Charting`realNumericQ]]], 
                    Dynamic[
                    Clip[$CellContext`d$$, 
                    Sort[
                    N[{0.001, 0.3}], Less]]], 0.001]), 0.0375}}]}, {}, 
                  
                  GeometricTransformationBox[{}, {{{1, 0}, {0, 1}}, {0, 
                    0}}]}, {
                 AlignmentPoint -> Center, AspectRatio -> Automatic, Axes -> 
                  False, AxesLabel -> None, AxesOrigin -> Automatic, 
                  AxesStyle -> {}, Background -> None, BaselinePosition -> 
                  Automatic, BaseStyle -> {}, ColorOutput -> Automatic, 
                  ContentSelectable -> Automatic, CoordinatesToolOptions -> 
                  Automatic, DisplayFunction -> Identity, Epilog -> {}, 
                  FormatType -> TraditionalForm, Frame -> False, FrameLabel -> 
                  None, FrameStyle -> {}, FrameTicks -> Automatic, 
                  FrameTicksStyle -> {}, GridLines -> None, 
                  GridLinesStyle -> {}, ImageMargins -> 0., ImagePadding -> 
                  All, ImageSize -> {230, 32}, ImageSizeRaw -> Automatic, 
                  LabelStyle -> {}, 
                  Method -> {
                   "DefaultBoundaryStyle" -> Automatic, 
                    "DefaultGraphicsInteraction" -> {
                    "Version" -> 1.2, "TrackMousePosition" -> {True, False}, 
                    "Effects" -> {
                    "Highlight" -> {"ratio" -> 2}, 
                    "HighlightPoint" -> {"ratio" -> 2}, 
                    "Droplines" -> {
                    "freeformCursorMode" -> True, 
                    "placement" -> {"x" -> "All", "y" -> "None"}}}}, 
                    "DefaultPlotStyle" -> Automatic}, PlotLabel -> None, 
                  PlotRange -> All, PlotRangeClipping -> False, 
                  PlotRangePadding -> Automatic, PlotRegion -> Automatic, 
                  PreserveImageOptions -> Automatic, Prolog -> {}, 
                  RotateLabel -> True, Ticks -> Automatic, TicksStyle -> {}, 
                  Axes -> False, Method -> Automatic}], Appearance -> None, 
                Enabled -> Automatic], DynamicModuleValues :> {}], 
              InputFieldBox[
               Dynamic[
                
                SetAccuracy[$CellContext`d$$, 
                 4], {($CellContext`d$$ = #)& , ($CellContext`d$$ = \
$CellContext`cost[#, {0.001, 0.3, 0.001}]; If[
                   NumericQ[$CellContext`d$$], 
                   $CellContext`c$$["evo"]])& }], Number, 
               FieldSize -> {4, 1}]},
             "RowDefault"]},
           {"\<\"\"\>", 
            ItemBox[
             TagBox[
              TooltipBox[
               ButtonBox["\<\"Reshuffle the course of epidemic\"\>",
                Appearance->Automatic,
                ButtonFunction:>$CellContext`c$$["evo"],
                Evaluator->Automatic,
                Method->"Preemptive"],
               
               "\"Pick a new course of epidemics with the same parameters, \
graph and initially infected.\"",
               TooltipStyle->"TextStyling"],
              
              Annotation[#, 
               "Pick a new course of epidemics with the same parameters, \
graph and initially infected.", "Tooltip"]& ],
             ContinuousAction -> True,
             Alignment->Center,
             StripOnInput->False]},
           {
            ItemBox["\<\"\"\>",
             StripOnInput->False], 
            ItemBox["\<\"\"\>",
             StripOnInput->False]},
           {
            TagBox[
             TooltipBox["\<\"Display groups:\"\>",
              "\"Pick which groups should be displayed on the graph.\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, 
              "Pick which groups should be displayed on the graph.", 
              "Tooltip"]& ], 
            TemplateBox[{
              InterpretationBox[
               StyleBox[
                GridBox[{{
                   SetterBox[
                    Dynamic[
                    MemberQ[$CellContext`groups$$, 1], 
                    BoxForm`TogglerBarFunction[$CellContext`groups$$, 1]& ], {
                    True}, "\"inf\"", Alignment -> Center, ContinuousAction -> 
                    True], 
                   SetterBox[
                    Dynamic[
                    MemberQ[$CellContext`groups$$, 2], 
                    BoxForm`TogglerBarFunction[$CellContext`groups$$, 2]& ], {
                    True}, "\"det\"", Alignment -> Center, ContinuousAction -> 
                    True], 
                   SetterBox[
                    Dynamic[
                    MemberQ[$CellContext`groups$$, 3], 
                    BoxForm`TogglerBarFunction[$CellContext`groups$$, 3]& ], {
                    True}, "\"sus\"", Alignment -> Center, ContinuousAction -> 
                    True], 
                   SetterBox[
                    Dynamic[
                    MemberQ[$CellContext`groups$$, 4], 
                    BoxForm`TogglerBarFunction[$CellContext`groups$$, 4]& ], {
                    True}, "\"rec\"", Alignment -> Center, ContinuousAction -> 
                    True], 
                   SetterBox[
                    Dynamic[
                    MemberQ[$CellContext`groups$$, 5], 
                    BoxForm`TogglerBarFunction[$CellContext`groups$$, 5]& ], {
                    True}, "\"dead\"", Alignment -> Center, ContinuousAction -> 
                    True]}}, ColumnSpacings -> 0, BaselinePosition -> {1, 1}],
                 Deployed -> True], 
               TogglerBar[
                Dynamic[$CellContext`groups$$], {
                1 -> "inf", 2 -> "det", 3 -> "sus", 4 -> "rec", 5 -> "dead"}, 
                Alignment -> Center, ContinuousAction -> True]], 
              TagBox[
               GridBox[{{
                  DynamicBox[
                   ToBoxes[
                    If[
                    And[
                    MemberQ[$CellContext`groups$$, 1], 
                    MemberQ[$CellContext`groups$$, 2]], 
                    Row[{
                    Checkbox[
                    
                    Dynamic[$CellContext`merge$$, {($CellContext`merge$$ = #)& \
, ($CellContext`merge$$ = #; $CellContext`c$$["refreshColors"]; Null)& }], {
                    False, True}], 
                    (Tooltip[#, "Display Infected and Detected together."]& )[
                    "Merge inf & det"]}], $CellContext`merge$$ = False; ""], 
                    StandardForm]]}, {
                  DynamicBox[
                   ToBoxes[
                    If[
                    And[
                    MemberQ[$CellContext`groups$$, 4], 
                    MemberQ[$CellContext`groups$$, 5]], 
                    Row[{
                    Checkbox[
                    
                    Dynamic[$CellContext`merge2$$, {($CellContext`merge2$$ = \
#)& , ($CellContext`merge2$$ = #; $CellContext`c$$["refreshColors"]; 
                    Null)& }], {False, True}], 
                    (Tooltip[#, "Display Recovered and Dead together."]& )[
                    "Merge rec & dead"]}], $CellContext`merge2$$ = False; ""],
                     StandardForm]]}}, 
                GridBoxAlignment -> {"Columns" -> {{Left}}}, DefaultBaseStyle -> 
                "Column", 
                GridBoxItemSize -> {
                 "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}], 
               "Column"]},
             "RowDefault"]},
           {
            ItemBox["\<\"\"\>",
             StripOnInput->False], 
            ItemBox["\<\"\"\>",
             StripOnInput->False]},
           {"\<\"\"\>", 
            ItemBox[
             TagBox[
              TooltipBox[
               StyleBox["\<\"Countermeasures\"\>",
                StripOnInput->False,
                FontSize->16,
                FontWeight->Bold],
               "\"Ways to fight with the epidemics.\"",
               TooltipStyle->"TextStyling"],
              Annotation[#, "Ways to fight with the epidemics.", "Tooltip"]& ],
             ContinuousAction -> True,
             Alignment->Center,
             StripOnInput->False]},
           {
            TagBox[
             TooltipBox["\<\"Quarantine for detected:\"\>",
              
              "\"Check how putting detected to the quarantine changes the \
course of epidemics.\"",
              TooltipStyle->"TextStyling"],
             
             Annotation[#, 
              "Check how putting detected to the quarantine changes the \
course of epidemics.", "Tooltip"]& ], 
            
            CheckboxBox[
             Dynamic[$CellContext`detCanInfect$$, \
{($CellContext`detCanInfect$$ = #)& , ($CellContext`detCanInfect$$ = #; \
$CellContext`c$$["evo"])& }], {True, False}]},
           {"\<\"\"\>", 
            ItemBox[
             ActionMenuBox[
              TagBox[
               TooltipBox["\<\"Add lockdown strategy\"\>",
                
                "\"Check how given lockdown strategy changes the course of \
epidemics, assuming everyone is grounded.\"",
                TooltipStyle->"TextStyling"],
               
               Annotation[#, 
                "Check how given lockdown strategy changes the course of \
epidemics, assuming everyone is grounded.", 
                "Tooltip"]& ], {"\<\"At 1% detected\"\>":>($CellContext`c$$[
               "addLS"]["At 1% detected"]; 
              Null), "\<\"At 2% detected\"\>":>($CellContext`c$$["addLS"][
               "At 2% detected"]; 
              Null), "\<\"At 5% detected\"\>":>($CellContext`c$$["addLS"][
               "At 5% detected"]; 
              Null), "\<\"At 10% detected\"\>":>($CellContext`c$$["addLS"][
               "At 10% detected"]; 
              Null), "\<\"At 15% detected\"\>":>($CellContext`c$$["addLS"][
               "At 15% detected"]; 
              Null), "\<\"At 50% detected\"\>":>($CellContext`c$$["addLS"][
               "At 50% detected"]; 
              Null), "\<\"At small change of detected\"\>":>($CellContext`c$$[
               "addLS"]["At small change of detected"]; 
              Null), "\<\"At large change of detected\"\>":>($CellContext`c$$[
               "addLS"]["At large change of detected"]; Null)},
              Appearance->"PopupMenu"],
             ContinuousAction -> True,
             Alignment->Center,
             StripOnInput->False]},
           {"\<\"\"\>", 
            DynamicBox[ToBoxes[
              Column[
               Table[
                Row[
                 With[{$CellContext`j$ = $CellContext`j}, {
                   Button[
                   "X", $CellContext`locks$$ = 
                    Delete[$CellContext`locks$$, $CellContext`j$]], 
                   
                   Part[$CellContext`locks$$, $CellContext`j$, 
                    1]}]], {$CellContext`j, 1, 
                 Length[$CellContext`locks$$]}]], StandardForm],
             ImageSizeCache->{4., {3.3837890625, 10.6162109375}}]},
           {"\<\"\"\>", 
            ItemBox[
             ButtonBox[
              TagBox[
               TooltipBox["\<\"Reshuffle lockdowns\"\>",
                
                "\"Recalculate the epidemics during lockdown, without \
recalculating the original course of epidemics.\"",
                TooltipStyle->"TextStyling"],
               
               Annotation[#, 
                "Recalculate the epidemics during lockdown, without \
recalculating the original course of epidemics.", "Tooltip"]& ],
              Appearance->Automatic,
              ButtonFunction:>$CellContext`c$$["locksRedo"],
              Evaluator->Automatic,
              Method->"Preemptive"],
             ContinuousAction -> True,
             Alignment->Center,
             StripOnInput->False]}
          },
          AutoDelete->False,
          GridBoxAlignment->{"Columns" -> {Right, Left}},
          GridBoxItemSize->{"Columns" -> {16, Automatic}},
          GridBoxItemStyle->{"Columns" -> {{"Text"}}, "Rows" -> {{"Text"}}},
          GridBoxSpacings->{"Columns" -> {{2}}, "Rows" -> {{0.5}}}],
         "Grid"]], 
       TagBox[GridBox[{
          {
           TemplateBox[{
             DynamicBox[
              ToBoxes[
               Refresh[
                If[$CellContext`CommunityQ$$, 
                 If[
                  $CellContext`commEnabled[$CellContext`network$$], 
                  
                  CommunityGraphPlot[$CellContext`graph$$, VertexSize -> 
                   0.02 $CellContext`n$$^(4/5), CommunityBoundaryStyle -> 
                   None, VertexStyle -> 
                   MapIndexed[
                    If[# == 3, Nothing, 
                    First[#2] -> $CellContext`gColors$$[#]]& , 
                    Part[$CellContext`courseOfEpidemics$$, 
                    Min[$CellContext`t$$, 
                    Length[$CellContext`courseOfEpidemics$$]]]]], 
                  
                  CommunityGraphPlot[$CellContext`graph$$, 
                   CommunityBoundaryStyle -> None, VertexStyle -> 
                   MapIndexed[
                    If[# == 3, Nothing, 
                    First[#2] -> $CellContext`gColors$$[#]]& , 
                    Part[$CellContext`courseOfEpidemics$$, 
                    Min[$CellContext`t$$, 
                    Length[$CellContext`courseOfEpidemics$$]]]]]], 
                 
                 Graph[$CellContext`graph$$, VertexStyle -> 
                  MapIndexed[
                   If[# == 3, Nothing, 
                    First[#2] -> $CellContext`gColors$$[#]]& , 
                    Part[$CellContext`courseOfEpidemics$$, 
                    Min[$CellContext`t$$, 
                    Length[$CellContext`courseOfEpidemics$$]]]]]], 
                TrackedSymbols :> {$CellContext`graph$$, \
$CellContext`courseOfEpidemics$$, $CellContext`t$$, $CellContext`gColors$$, \
$CellContext`CommunityQ$$}], StandardForm], SynchronousUpdating -> False], 
             DynamicBox[
              ToBoxes[
               SwatchLegend[
                If[$CellContext`merge2$$, $CellContext`mergeRDcolor, Identity][
                 If[$CellContext`merge$$, $CellContext`mergeDIcolor, Identity][
                  Values[$CellContext`colors]]], 
                If[$CellContext`merge2$$, $CellContext`mergeRDtext, Identity][
                
                 If[$CellContext`merge$$, $CellContext`mergeDItext, Identity][
                 
                  Values[$CellContext`groupAssoc]]], LegendMarkers -> 
                "Bubble", LegendMarkerSize -> 15, LegendLayout -> "Row", 
                LabelStyle -> {FontSize -> 14}], StandardForm]]},
            "Legended",
            DisplayFunction->(GridBox[{{
                TagBox[
                 ItemBox[
                  PaneBox[
                   TagBox[#, "SkipImageSizeLevel"], 
                   Alignment -> {Center, Baseline}, BaselinePosition -> 
                   Baseline], DefaultBaseStyle -> "Labeled"], 
                 "SkipImageSizeLevel"]}, {
                ItemBox[#2, DefaultBaseStyle -> "LabeledLabel"]}}, 
              GridBoxAlignment -> {
               "Columns" -> {{Center}}, "Rows" -> {{Center}}}, AutoDelete -> 
              False, GridBoxItemSize -> Automatic, 
              BaselinePosition -> {1, 1}]& ),
            Editable->True,
            InterpretationFunction->(RowBox[{"Legended", "[", 
               RowBox[{#, ",", 
                 RowBox[{"Placed", "[", 
                   RowBox[{#2, ",", "Below"}], "]"}]}], "]"}]& )]},
          {
           TemplateBox[{
             DynamicBox[
              ToBoxes[
               Refresh[
                $CellContext`StatPlot[$CellContext`stats$$, 
                 Dynamic[$CellContext`t$$], $CellContext`tmax$$, 
                 Sort[$CellContext`groups$$], 
                 If[Length[$CellContext`locks$$] > 0, 
                  
                  Part[$CellContext`locks$$, All, {2, -1, 
                   1}], $CellContext`locks$$], $CellContext`merge$$, \
$CellContext`merge2$$], 
                TrackedSymbols :> {$CellContext`stats$$, \
$CellContext`locks$$, $CellContext`groups$$, $CellContext`merge$$, \
$CellContext`merge2$$}], StandardForm]], "\"time\""},
            "Labeled",
            DisplayFunction->(GridBox[{{
                TagBox[
                 ItemBox[
                  PaneBox[
                   TagBox[#, "SkipImageSizeLevel"], 
                   Alignment -> {Center, Baseline}, BaselinePosition -> 
                   Baseline], DefaultBaseStyle -> "Labeled"], 
                 "SkipImageSizeLevel"]}, {
                
                ItemBox[#2, BaseStyle -> 
                 Directive[FontFamily -> "Helvetica", FontSize -> 16], 
                 DefaultBaseStyle -> "LabeledLabel"]}}, 
              GridBoxAlignment -> {
               "Columns" -> {{Center}}, "Rows" -> {{Center}}}, AutoDelete -> 
              False, GridBoxItemSize -> {
               "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
              GridBoxSpacings -> {"Columns" -> {{0}}, "Rows" -> {{1}}}, 
              BaselinePosition -> {1, 1}]& ),
            InterpretationFunction->(RowBox[{"Labeled", "[", 
               RowBox[{#, ",", 
                 RowBox[{"{", #2, "}"}], ",", 
                 RowBox[{"{", "Bottom", "}"}], ",", 
                 RowBox[{"ImageMargins", "\[Rule]", "0"}], ",", 
                 RowBox[{"FrameMargins", "\[Rule]", "0"}], ",", 
                 RowBox[{"Spacings", "\[Rule]", 
                   RowBox[{"{", 
                    RowBox[{"0", ",", "1"}], "}"}]}], ",", 
                 RowBox[{"LabelStyle", "\[Rule]", 
                   RowBox[{"Directive", "[", 
                    RowBox[{
                    RowBox[{"FontFamily", "\[Rule]", "\"Helvetica\""}], ",", 
                    RowBox[{"FontSize", "\[Rule]", "16"}]}], "]"}]}]}], 
               "]"}]& )]}
         },
         DefaultBaseStyle->"Column",
         GridBoxAlignment->{"Columns" -> {{Left}}},
         GridBoxItemSize->{
          "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
        "Column"]},
      {
       PanelBox[
        InterpretationBox[
         StyleBox[GridBox[{
            {
             AnimatorBox[Dynamic[$CellContext`t$$], {1, 
               Dynamic[$CellContext`tmax$$], 1},
              AnimationRepetitions->1,
              AnimationRunTime->0.,
              AnimationRunning->False,
              
              AppearanceElements->{
               "ProgressSlider", "PlayPauseButton", "ResetButton", 
                "StepLeftButton", "StepRightButton", "FasterSlowerButtons"},
              DisplayAllSteps->True,
              ImageSize->850], 
             InputFieldBox[Dynamic[$CellContext`t$$],
              Appearance->"Frameless",
              FieldSize->{{5, 10}, {1, 2}}]}
           },
           AutoDelete->False,
           BaselinePosition->{{1, 1}, Axis},
           
           GridBoxItemSize->{
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}},
           GridBoxSpacings->{"Columns" -> {
               Offset[0.27999999999999997`], {
                Offset[0.7]}, 
               Offset[0.27999999999999997`]}, "Rows" -> {
               Offset[0.2], {
                Offset[0.4]}, 
               Offset[0.2]}}],
          Deployed->True,
          StripOnInput->False,
          FontFamily:>CurrentValue["ControlsFontFamily"]],
         Animator[
          Dynamic[$CellContext`t$$], {1, 
           Dynamic[$CellContext`tmax$$], 1}, 
          AppearanceElements -> {
           "ProgressSlider", "PlayPauseButton", "ResetButton", 
            "StepLeftButton", "StepRightButton", "FasterSlowerButtons"}, 
          AnimationRunning -> False, AnimationRepetitions -> 1, 
          DisplayAllSteps -> True, ImageSize -> 850, DisplayAllSteps -> True, 
          Appearance -> "Labeled"]]], "\[SpanFromLeft]"}
     },
     AutoDelete->False,
     Editable->False,
     GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
    "Grid"],
   Deploy,
   DefaultBaseStyle->"Deploy"],
  TrackedSymbols :> {},
  DynamicModuleValues:>{{DownValues[$CellContext`c$$] = {HoldPattern[
         $CellContext`c$$["all"]] :> ($CellContext`c$$[
         "graph"]; $CellContext`c$$["initial"]; $CellContext`c$$[
         "simulation"]; $CellContext`c$$["locksRedo"]; Null), HoldPattern[
         $CellContext`c$$["evo"]] :> ($CellContext`c$$[
         "simulation"]; $CellContext`c$$["locksRedo"]; Null), HoldPattern[
         $CellContext`c$$["graph"]] :> ($CellContext`graph$$ = Graph[
          $CellContext`GraphPostprocess[
           $CellContext`graphs[$CellContext`network$$][$CellContext`n$$, \
$CellContext`\[Rho]$$, $CellContext`k$$]], BaseStyle -> EdgeForm[], 
          VertexSize -> 0.6, 
          ImageSize -> {$CellContext`previewSize, $CellContext`previewSize}, 
          VertexStyle -> $CellContext`colors[3], EdgeStyle -> Lighter[
            $CellContext`colors[3]], ImageMargins -> 0, ImagePadding -> 0]), 
       HoldPattern[
         $CellContext`c$$["initial"]] :> ($CellContext`initialList$$ = 
         ConstantArray[3, 
           VertexCount[$CellContext`graph$$]]; 
        Do[
         Part[$CellContext`initialList$$, $CellContext`i] = 
          1, {$CellContext`i, 
           RandomChoice[
            Range[
             VertexCount[$CellContext`graph$$]], 
            Ceiling[$CellContext`p$$]]}]), HoldPattern[
         $CellContext`c$$["locksRedo"]] :> (
        If[Length[$CellContext`locks$$] > 
          0, $CellContext`locksTmp$$ = 
           Part[$CellContext`locks$$, All, 
             1]; $CellContext`locks$$ = {}; $CellContext`locks$$ = {}; 
          Map[($CellContext`c$$["addLS"][#]; 
            Null)& , $CellContext`locksTmp$$]]; Null), HoldPattern[
         $CellContext`c$$["pop"]] :> ($CellContext`c$$[
         "initial"]; $CellContext`c$$["simulation"]; $CellContext`c$$[
         "locksRedo"]; Null), HoldPattern[
         $CellContext`c$$[
         "refreshColors"]] :> ($CellContext`gColors$$ = $CellContext`colors; 
        If[$CellContext`merge$$, $CellContext`gColors$$[1] = Blend[{
              $CellContext`colors[1], 
              $CellContext`colors[2]}]; $CellContext`gColors$$[
            2] = $CellContext`gColors$$[1]; Null]; 
        If[$CellContext`merge2$$, $CellContext`gColors$$[4] = Blend[{
              $CellContext`colors[4], 
              $CellContext`colors[5]}]; $CellContext`gColors$$[
            5] = $CellContext`gColors$$[4]; Null]; Null), HoldPattern[
         $CellContext`c$$[
         "simulation"]] :> ({$CellContext`courseOfEpidemics$$, \
$CellContext`ls$$, $CellContext`size$$, $CellContext`tmax$$} = \
$CellContext`simulation[$CellContext`graph$$, $CellContext`initialList$$, \
$CellContext`\[Lambda]$$, $CellContext`g$$, $CellContext`d$$, \
$CellContext`o$$, $CellContext`detCanInfect$$, 
           None, $CellContext`hardtmax]; $CellContext`stats$$ = Transpose[
           
           Map[$CellContext`statify[#]/$CellContext`size$$& , \
$CellContext`courseOfEpidemics$$]]; Null)}, 
     SubValues[$CellContext`c$$] = {HoldPattern[
         $CellContext`c$$["addLS"]["At 10% detected"]] :> (
        AppendTo[$CellContext`locks$$, 
          ({"At 10% detected", 
           Part[#, 1], 
           $CellContext`simulation[$CellContext`graph$$, 
            
            Part[#, 2], $CellContext`\[Lambda]$$, $CellContext`g$$, \
$CellContext`d$$, $CellContext`o$$, $CellContext`detCanInfect$$, 
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 10], $CellContext`history -> {}], $CellContext`hardtmax]}& \
)[
           $CellContext`FirstLockdownStep[
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 10], $CellContext`history -> {}], \
$CellContext`courseOfEpidemics$$, $CellContext`size$$]]]; AppendTo[
          Part[$CellContext`locks$$, -1], 
          Transpose[
           Map[$CellContext`statify[#]/$CellContext`size$$& , 
            Part[
             Part[
              Part[$CellContext`locks$$, -1], 3], 1]]]]; Null), HoldPattern[
         $CellContext`c$$["addLS"]["At 15% detected"]] :> (
        AppendTo[$CellContext`locks$$, 
          ({"At 15% detected", 
           Part[#, 1], 
           $CellContext`simulation[$CellContext`graph$$, 
            
            Part[#, 2], $CellContext`\[Lambda]$$, $CellContext`g$$, \
$CellContext`d$$, $CellContext`o$$, $CellContext`detCanInfect$$, 
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              3, 20], $CellContext`history -> {}], $CellContext`hardtmax]}& \
)[
           $CellContext`FirstLockdownStep[
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              3, 20], $CellContext`history -> {}], \
$CellContext`courseOfEpidemics$$, $CellContext`size$$]]]; AppendTo[
          Part[$CellContext`locks$$, -1], 
          Transpose[
           Map[$CellContext`statify[#]/$CellContext`size$$& , 
            Part[
             Part[
              Part[$CellContext`locks$$, -1], 3], 1]]]]; Null), HoldPattern[
         $CellContext`c$$["addLS"]["At 1% detected"]] :> (
        AppendTo[$CellContext`locks$$, 
          ({"At 1% detected", 
           Part[#, 1], 
           $CellContext`simulation[$CellContext`graph$$, 
            
            Part[#, 2], $CellContext`\[Lambda]$$, $CellContext`g$$, \
$CellContext`d$$, $CellContext`o$$, $CellContext`detCanInfect$$, 
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 100], $CellContext`history -> {}], $CellContext`hardtmax]}& )[
           $CellContext`FirstLockdownStep[
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 100], $CellContext`history -> {}], \
$CellContext`courseOfEpidemics$$, $CellContext`size$$]]]; AppendTo[
          Part[$CellContext`locks$$, -1], 
          Transpose[
           Map[$CellContext`statify[#]/$CellContext`size$$& , 
            Part[
             Part[
              Part[$CellContext`locks$$, -1], 3], 1]]]]; Null), HoldPattern[
         $CellContext`c$$["addLS"]["At 2% detected"]] :> (
        AppendTo[$CellContext`locks$$, 
          ({"At 2% detected", 
           Part[#, 1], 
           $CellContext`simulation[$CellContext`graph$$, 
            
            Part[#, 2], $CellContext`\[Lambda]$$, $CellContext`g$$, \
$CellContext`d$$, $CellContext`o$$, $CellContext`detCanInfect$$, 
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 50], $CellContext`history -> {}], $CellContext`hardtmax]}& \
)[
           $CellContext`FirstLockdownStep[
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 50], $CellContext`history -> {}], \
$CellContext`courseOfEpidemics$$, $CellContext`size$$]]]; AppendTo[
          Part[$CellContext`locks$$, -1], 
          Transpose[
           Map[$CellContext`statify[#]/$CellContext`size$$& , 
            Part[
             Part[
              Part[$CellContext`locks$$, -1], 3], 1]]]]; Null), HoldPattern[
         $CellContext`c$$["addLS"]["At 50% detected"]] :> (
        AppendTo[$CellContext`locks$$, 
          ({"At 50% detected", 
           Part[#, 1], 
           $CellContext`simulation[$CellContext`graph$$, 
            
            Part[#, 2], $CellContext`\[Lambda]$$, $CellContext`g$$, \
$CellContext`d$$, $CellContext`o$$, $CellContext`detCanInfect$$, 
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 2], $CellContext`history -> {}], $CellContext`hardtmax]}& )[
           $CellContext`FirstLockdownStep[
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 2], $CellContext`history -> {}], \
$CellContext`courseOfEpidemics$$, $CellContext`size$$]]]; AppendTo[
          Part[$CellContext`locks$$, -1], 
          Transpose[
           Map[$CellContext`statify[#]/$CellContext`size$$& , 
            Part[
             Part[
              Part[$CellContext`locks$$, -1], 3], 1]]]]; Null), HoldPattern[
         $CellContext`c$$["addLS"]["At 5% detected"]] :> (
        AppendTo[$CellContext`locks$$, 
          ({"At 5% detected", 
           Part[#, 1], 
           $CellContext`simulation[$CellContext`graph$$, 
            
            Part[#, 2], $CellContext`\[Lambda]$$, $CellContext`g$$, \
$CellContext`d$$, $CellContext`o$$, $CellContext`detCanInfect$$, 
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 20], $CellContext`history -> {}], $CellContext`hardtmax]}& \
)[
           $CellContext`FirstLockdownStep[
            
            Association[$CellContext`Fun -> (
              Count[#, 2]/#3& ), $CellContext`threshold -> 
             Rational[
              1, 20], $CellContext`history -> {}], \
$CellContext`courseOfEpidemics$$, $CellContext`size$$]]]; AppendTo[
          Part[$CellContext`locks$$, -1], 
          Transpose[
           Map[$CellContext`statify[#]/$CellContext`size$$& , 
            Part[
             Part[
              Part[$CellContext`locks$$, -1], 3], 1]]]]; Null), HoldPattern[
         $CellContext`c$$["addLS"]["At large change of detected"]] :> (
        AppendTo[$CellContext`locks$$, 
          ({"At large change of detected", 
           Part[#, 1], 
           $CellContext`simulation[$CellContext`graph$$, 
            
            Part[#, 2], $CellContext`\[Lambda]$$, $CellContext`g$$, \
$CellContext`d$$, $CellContext`o$$, $CellContext`detCanInfect$$, 
            
            Association[$CellContext`Fun -> (If[
              Length[#2] > 0, Count[#, 2]/#3 - Part[#2, -1, 2], 
               Count[#, 2]/#3]& ), $CellContext`threshold -> 
             0.1, $CellContext`history -> {}], $CellContext`hardtmax]}& )[
           $CellContext`FirstLockdownStep[
            
            Association[$CellContext`Fun -> (If[
              Length[#2] > 0, Count[#, 2]/#3 - Part[#2, -1, 2], 
               Count[#, 2]/#3]& ), $CellContext`threshold -> 
             0.1, $CellContext`history -> {}], \
$CellContext`courseOfEpidemics$$, $CellContext`size$$]]]; AppendTo[
          Part[$CellContext`locks$$, -1], 
          Transpose[
           Map[$CellContext`statify[#]/$CellContext`size$$& , 
            Part[
             Part[
              Part[$CellContext`locks$$, -1], 3], 1]]]]; Null), HoldPattern[
         $CellContext`c$$["addLS"]["At small change of detected"]] :> (
        AppendTo[$CellContext`locks$$, 
          ({"At small change of detected", 
           Part[#, 1], 
           $CellContext`simulation[$CellContext`graph$$, 
            
            Part[#, 2], $CellContext`\[Lambda]$$, $CellContext`g$$, \
$CellContext`d$$, $CellContext`o$$, $CellContext`detCanInfect$$, 
            
            Association[$CellContext`Fun -> (If[
              Length[#2] > 0, Count[#, 2]/#3 - Part[#2, -1, 2], 
               Count[#, 2]/#3]& ), $CellContext`threshold -> 
             0.01, $CellContext`history -> {}], $CellContext`hardtmax]}& )[
           $CellContext`FirstLockdownStep[
            
            Association[$CellContext`Fun -> (If[
              Length[#2] > 0, Count[#, 2]/#3 - Part[#2, -1, 2], 
               Count[#, 2]/#3]& ), $CellContext`threshold -> 
             0.01, $CellContext`history -> {}], \
$CellContext`courseOfEpidemics$$, $CellContext`size$$]]]; AppendTo[
          Part[$CellContext`locks$$, -1], 
          Transpose[
           Map[$CellContext`statify[#]/$CellContext`size$$& , 
            Part[
             Part[
              Part[$CellContext`locks$$, -1], 3], 1]]]]; Null)}}},
  Initialization:>({$CellContext`\[Rho]Tooltip = 
     Association[
      "Grid" -> "Not available in this network type", "Scale-Free" -> 
       "Not available in this network type", "Small-World (WS)" -> 
       "Probability of edge rewiring during network construction. Makes \
possibility of long range connections.", "Small-World (KM)" -> 
       "Probability of changing the edges that connect vertices during \
construction.", "Holed Grid" -> "Not available in this network type", 
       "Random" -> "Not available in this network type", "k-Grid" -> 
       "Not available in this network type", "2k-regular" -> 
       "Not available in this network type"], $CellContext`rhoEnabled = 
     Association[
      "Grid" -> False, "Scale-Free" -> False, "Small-World (WS)" -> True, 
       "Small-World (KM)" -> True, "Holed Grid" -> False, "Random" -> False, 
       "k-Grid" -> False, "2k-regular" -> False], $CellContext`kTooltip = 
     Association[
      "Grid" -> "Not available in this network type", "Scale-Free" -> 
       "Influences how many edges each new vertex will have during network \
construction. ", "Small-World (WS)" -> 
       "Half the mean number of target neighbours.", "Small-World (KM)" -> 
       "Not available in this network type", "Holed Grid" -> 
       "Number of ruby-shaped holes (disk in manhattan-like metric) in the \
Grid Graph. Their size is automatically adjusted to their count.", "Random" -> 
       "Mean number of edges per vertex, before discarding isolated nodes.", 
       "k-Grid" -> "Connect all neighbours up to distance k.", "2k-regular" -> 
       "Connect all neighbours up to distance k."], $CellContext`kEnabled = 
     Association[
      "Grid" -> False, "Scale-Free" -> True, "Small-World (WS)" -> True, 
       "Small-World (KM)" -> False, "Holed Grid" -> True, "Random" -> True, 
       "k-Grid" -> True, "2k-regular" -> True], $CellContext`cost[
       Pattern[$CellContext`val, 
        Blank[]], {
        Pattern[$CellContext`min, 
         Blank[]], 
        Pattern[$CellContext`max, 
         Blank[]], 
        Pattern[$CellContext`step, 
         Blank[]]}] := Min[
       Max[
        Round[$CellContext`val, $CellContext`step], $CellContext`min], \
$CellContext`max], 
     Attributes[$CellContext`j$] = {Temporary}, $CellContext`commEnabled = 
     Association[
      "Grid" -> False, "Scale-Free" -> True, "Small-World (WS)" -> True, 
       "Small-World (KM)" -> True, "Holed Grid" -> False, "Random" -> True, 
       "k-Grid" -> False, "2k-regular" -> False], $CellContext`mergeRDcolor[{
        Pattern[$CellContext`rest, 
         BlankNullSequence[]], 
        Pattern[$CellContext`rec, 
         Blank[]], 
        Pattern[$CellContext`dead, 
         Blank[]]}] := {$CellContext`rest, 
       Blend[{$CellContext`rec, $CellContext`dead}]}, \
$CellContext`mergeDIcolor[{
        Pattern[$CellContext`inf, 
         Blank[]], 
        Pattern[$CellContext`det, 
         Blank[]], 
        Pattern[$CellContext`rest, 
         BlankNullSequence[]]}] := {
       Blend[{$CellContext`inf, $CellContext`det}], $CellContext`rest}, \
$CellContext`colors = 
     Association[
      1 -> RGBColor[1, 0, 0], 2 -> RGBColor[1, 0.6666666666666666, 1/3], 3 -> 
       RGBColor[0.6666666666666666, 0.6666666666666666, 0.6666666666666666], 
       4 -> RGBColor[0.54, 1., 0.94], 5 -> 
       GrayLevel[0]], $CellContext`mergeRDtext[{
        Pattern[$CellContext`rest, 
         BlankNullSequence[]], 
        Pattern[$CellContext`rec, 
         Blank[]], 
        Pattern[$CellContext`dead, 
         Blank[]]}] := {$CellContext`rest, 
       StringJoin[$CellContext`rec, 
        "+", $CellContext`dead]}, $CellContext`mergeDItext[{
        Pattern[$CellContext`inf, 
         Blank[]], 
        Pattern[$CellContext`det, 
         Blank[]], 
        Pattern[$CellContext`rest, 
         BlankNullSequence[]]}] := {
       StringJoin[$CellContext`inf, 
        "+", $CellContext`det], $CellContext`rest}, $CellContext`groupAssoc = 
     Association[
      1 -> "inf", 2 -> "det", 3 -> "sus", 4 -> "rec", 5 -> 
       "dead"], $CellContext`StatPlot[
       Pattern[$CellContext`stats$, 
        Blank[]], 
       Pattern[$CellContext`i$, 
        Blank[]], 
       Pattern[$CellContext`tmax$, 
        Blank[]], 
       Pattern[$CellContext`groups$, 
        Blank[]], 
       Optional[
        Pattern[$CellContext`lds$, 
         Blank[]], {}], 
       Pattern[$CellContext`merge$, 
        Blank[]], 
       Pattern[$CellContext`merge2$, 
        Blank[]]] := Show[
       ListLinePlot[
        If[$CellContext`merge2$, $CellContext`mergeRD, Identity][
         If[$CellContext`merge$, $CellContext`mergeDI, Identity][
          Part[$CellContext`stats$, $CellContext`groups$]]], PlotStyle -> 
        If[$CellContext`merge2$, $CellContext`mergeRDcolor, Identity][
          If[$CellContext`merge$, $CellContext`mergeDIcolor, Identity][
           Part[
            Values[$CellContext`colors], $CellContext`groups$]]], 
        PlotRange -> {{1, $CellContext`tmax$}, {0, 1}}, AspectRatio -> 0.6, 
        ImageSize -> {$CellContext`previewSize, $CellContext`previewSize 0.6},
         Epilog -> {Thick, Dashed, 
          Line[{{$CellContext`i$, 0}, {$CellContext`i$, 1}}]}, Frame -> True, 
        FrameLabel -> {{None, None}, {None, None}}, 
        FrameTicks -> $CellContext`ticks, FrameStyle -> Directive[Black, 14]], 
       Apply[Sequence, 
        Table[
         ListLinePlot[
          If[$CellContext`merge2$, $CellContext`mergeRD, Identity][
           If[$CellContext`merge$, $CellContext`mergeDI, Identity][
            Part[
             Part[
              Part[$CellContext`lds$, FE`k$$1], 2], $CellContext`groups$]]], 
          DataRange -> {
            Part[
             Part[$CellContext`lds$, FE`k$$1], 1], Part[
              Part[$CellContext`lds$, FE`k$$1], 1] + Length[
              Part[
               Part[
                Part[$CellContext`lds$, FE`k$$1], 2], 1]] - 1}, PlotStyle -> 
          Map[Directive[
             Part[{Dotted, Dashed, DotDashed}, 
              Mod[FE`k$$1, 2, 1]], 
             Nest[Lighter, #, FE`k$$1]]& , 
            If[$CellContext`merge2$, $CellContext`mergeRDcolor, Identity][
             If[$CellContext`merge$, $CellContext`mergeDIcolor, Identity][
              Part[
               Values[$CellContext`colors], $CellContext`groups$]]]], 
          PlotLegends -> Placed[{
             Part[
              Part[$CellContext`lds$, FE`k$$1], 3]}, {
             Part[{Left, Right}, 
              Mod[FE`k$$1, 2, 1]], Top}]], {FE`k$$1, 1, 
          Length[$CellContext`lds$]}]]], 
     Attributes[$CellContext`stats$] = {Temporary}, 
     Attributes[$CellContext`i$] = {Temporary}, 
     Attributes[$CellContext`tmax$] = {Temporary}, 
     Attributes[$CellContext`groups$] = {Temporary}, 
     Attributes[$CellContext`lds$] = {Temporary}, 
     Attributes[$CellContext`merge$] = {Temporary}, 
     Attributes[$CellContext`merge2$] = {Temporary}, $CellContext`mergeRD[{
        Pattern[$CellContext`rest, 
         BlankNullSequence[]], 
        Pattern[$CellContext`rec, 
         Blank[]], 
        Pattern[$CellContext`dead, 
         Blank[]]}] := {$CellContext`rest, $CellContext`rec + \
$CellContext`dead}, $CellContext`mergeDI[{
        Pattern[$CellContext`inf, 
         Blank[]], 
        Pattern[$CellContext`det, 
         Blank[]], 
        Pattern[$CellContext`rest, 
         BlankNullSequence[]]}] := {$CellContext`inf + $CellContext`det, \
$CellContext`rest}, $CellContext`previewSize = 
     500, $CellContext`ticks = {{
       None, {{0, "0%"}, {0.1, "10%"}, {0.2, "20%"}, {0.3, "30%"}, {
         0.4, "40%"}, {0.5, "50%"}, {0.6, "60%"}, {0.7, "70%"}, {
         0.8, "80%"}, {0.9, "90%"}, {1, "100%"}}}, {Automatic, Automatic}}, 
     FE`k$$1 = 2}; ($CellContext`neighboursOfVerticesList := Table[
       Complement[
        VertexList[
         NeighborhoodGraph[#, $CellContext`node]], {$CellContext`node}], \
{$CellContext`node, 
        VertexList[#]}]& ; $CellContext`largestSubgraph := Subgraph[#, 
       First[
        ConnectedComponents[#]]]& ; $CellContext`gridBasedSW := 
     Block[{$CellContext`base = #, $CellContext`temp, $CellContext`length, \
$CellContext`drawPool}, $CellContext`temp = 
        EdgeList[$CellContext`base]; $CellContext`length = Length[
          VertexList[$CellContext`base]]; Do[
         If[RandomReal[] < #2, $CellContext`drawPool = Complement[
             Range[$CellContext`length], 
             AdjacencyList[$CellContext`temp, 
              Part[$CellContext`temp, $CellContext`edgeInd, 1]]]; 
          If[Length[$CellContext`drawPool] > 0, 
            Part[$CellContext`temp, $CellContext`edgeInd, 2] = 
            RandomChoice[$CellContext`drawPool], 
            Continue[]], Continue[]; Null], {$CellContext`edgeInd, 
          Length[
           EdgeList[$CellContext`temp]]}]; (Graph[
         Range[$CellContext`length], #, GraphLayout -> 
         "GridEmbedding"]& )[$CellContext`temp]]& ; $CellContext`MakeHoles[
       Pattern[$CellContext`graph, 
        Blank[Graph]], 
       Pattern[$CellContext`count, 
        Blank[Integer]], 
       Optional[
        Pattern[$CellContext`maxSize, 
         Blank[Integer]], 1]] := Nest[Subgraph[#, 
        Complement[
         VertexList[#], 
         VertexList[
          NeighborhoodGraph[#, 
           RandomSample[
            VertexList[#], 
            1], $CellContext`maxSize]]]]& , $CellContext`graph, \
$CellContext`count]; $CellContext`KeepLayout[
       Pattern[$CellContext`graph, 
        Blank[Graph]], 
       Pattern[$CellContext`fun, 
        Blank[]], 
       Pattern[$CellContext`funParams, 
        BlankNullSequence[]]] := 
     Block[{$CellContext`coords, $CellContext`gs}, $CellContext`gs = \
$CellContext`fun[$CellContext`graph, $CellContext`funParams]; \
$CellContext`coords = 
        Map[# -> PropertyValue[{$CellContext`graph, #}, VertexCoordinates]& , 
          
          VertexList[$CellContext`gs]]; 
       Graph[$CellContext`gs, 
         VertexCoordinates -> $CellContext`coords]]; $CellContext`uniform := 
     RandomGraph[{#, # #3}, GraphLayout -> 
       "GridEmbedding"]& ; $CellContext`grid := GridGraph[{
        Sqrt[#], 
        Sqrt[#]}]& ; $CellContext`scaleFree := RandomGraph[
       BarabasiAlbertGraphDistribution[#, #3], GraphLayout -> 
       "GridEmbedding"]& ; $CellContext`smallWorld := RandomGraph[
       WattsStrogatzGraphDistribution[#, #2, #3], GraphLayout -> 
       "GridEmbedding"]& ; $CellContext`smallWorld2 := \
$CellContext`gridBasedSW[
       $CellContext`grid[#], #2]& ; $CellContext`holedGrid := \
$CellContext`KeepLayout[
       $CellContext`grid[#], $CellContext`MakeHoles, #3, 
       Max[IntegerPart[Sqrt[#]/3] - #3, 1]]& ; $CellContext`advGrid := 
     Block[{$CellContext`pts, $CellContext`distances}, $CellContext`pts = 
        Tuples[
          Range[
           Sqrt[#]], 2]; $CellContext`distances = With[{$CellContext`tr = N[
             Transpose[$CellContext`pts]]}, 
          Map[
           Function[$CellContext`point, 
            Sqrt[
             
             Total[($CellContext`point - $CellContext`tr)^2]]], \
$CellContext`pts]]; SimpleGraph[
         AdjacencyGraph[
          UnitStep[#3 - $CellContext`distances]], 
         VertexCoordinates -> $CellContext`pts]]& ; $CellContext`regular2k := 
     CirculantGraph[#, 
       Range[#3], GraphLayout -> 
       "GridEmbedding"]& ; $CellContext`GraphPostprocess := IndexGraph[
       $CellContext`largestSubgraph[
        SimpleGraph[#]]]& ; $CellContext`notAv = 
     "Not available in this network type"; $CellContext`graphsInfo = 
     Association[
      "Grid" -> {$CellContext`grid, False, False, 
         False, $CellContext`notAv, $CellContext`notAv, 
         "Lattice network of edge \!\(\*SqrtBox[\(n\)]\).\nSee GridGraph in \
Mathematica."}, 
       "Scale-Free" -> {$CellContext`scaleFree, False, True, 
         True, $CellContext`notAv, 
         "Influences how many edges each new vertex will have during network \
construction. ", 
         "Random network built on top of 3-vertex cycle graph.\nSee \
BarabasiAlbertGraphDistribution in Mathematica."}, 
       "Small-World (WS)" -> {$CellContext`smallWorld, True, True, True, 
         "Probability of edge rewiring during network construction. Makes \
possibility of long range connections.", 
         "Half the mean number of target neighbours.", 
         "Random network based on 2k\[Dash]regular graph.\nSee \
WattsStrogatzGraphDistribution in Mathematica."}, 
       "Small-World (KM)" -> {$CellContext`smallWorld2, True, False, True, 
         "Probability of changing the edges that connect vertices during \
construction.", $CellContext`notAv, 
         "Random network based on grid graph.\nSee gridBasedSW function \
definition."}, 
       "Holed Grid" -> {$CellContext`holedGrid, False, True, 
         False, $CellContext`notAv, 
         "Number of ruby-shaped holes (disk in manhattan-like metric) in the \
Grid Graph. Their size is automatically adjusted to their count.", 
         "Random network based on grid graph with some vertices removed.\nSee \
holedGrid function definition."}, 
       "Random" -> {$CellContext`uniform, False, True, 
         True, $CellContext`notAv, 
         "Mean number of edges per vertex, before discarding isolated nodes.",
          "Random network.\nSee RandomGraph in Mathematica."}, 
       "k-Grid" -> {$CellContext`advGrid, False, True, 
         False, $CellContext`notAv, 
         "Connect all neighbours up to distance k.", 
         "Lattice network with k nearest neighbours.\nSee advGrid function \
definition."}, 
       "2k-regular" -> {$CellContext`regular2k, False, True, 
         False, $CellContext`notAv, 
         "Connect all neighbours up to distance k.", 
         "Circular network with k nearest neighbours.\nSee CirculantGraph in \
Mathematica."}]; $CellContext`graphs = AssociationThread[
       Keys[$CellContext`graphsInfo], 
       Map[First, 
        Values[$CellContext`graphsInfo]]]; $CellContext`rhoEnabled = 
     AssociationThread[
       Keys[$CellContext`graphsInfo], 
       Map[Part[#, 2]& , 
        Values[$CellContext`graphsInfo]]]; $CellContext`kEnabled = 
     AssociationThread[
       Keys[$CellContext`graphsInfo], 
       Map[Part[#, 3]& , 
        Values[$CellContext`graphsInfo]]]; $CellContext`commEnabled = 
     AssociationThread[
       Keys[$CellContext`graphsInfo], 
       Map[Part[#, 4]& , 
        Values[$CellContext`graphsInfo]]]; $CellContext`\[Rho]Tooltip = 
     AssociationThread[
       Keys[$CellContext`graphsInfo], 
       Map[Part[#, 5]& , 
        Values[$CellContext`graphsInfo]]]; $CellContext`kTooltip = 
     AssociationThread[
       Keys[$CellContext`graphsInfo], 
       Map[Part[#, 6]& , 
        Values[$CellContext`graphsInfo]]]; $CellContext`graphTooltip = 
     AssociationThread[
       Keys[$CellContext`graphsInfo], 
       Map[Part[#, 7]& , 
        Values[$CellContext`graphsInfo]]]; $CellContext`lsDetCount = 
     Association[$CellContext`Fun -> (
        Count[#, 2]/#3& ), $CellContext`threshold -> 
       0.01, $CellContext`history -> {}]; $CellContext`lsDetChangeSmall = 
     Association[$CellContext`Fun -> (If[
        Length[#2] > 0, Count[#, 2]/#3 - Part[#2, -1, 2], 
         Count[#, 2]/#3]& ), $CellContext`threshold -> 
       0.01, $CellContext`history -> {}]; $CellContext`lsDetChangeLarge = 
     Association[$CellContext`Fun -> (If[
        Length[#2] > 0, Count[#, 2]/#3 - Part[#2, -1, 2], 
         Count[#, 2]/#3]& ), $CellContext`threshold -> 
       0.1, $CellContext`history -> {}]; $CellContext`lsStrategies = 
     Association[
      "At 1% detected" -> 
       Association[$CellContext`Fun -> (
          Count[#, 2]/#3& ), $CellContext`threshold -> 
         1/100, $CellContext`history -> {}], "At 2% detected" -> 
       Association[$CellContext`Fun -> (
          Count[#, 2]/#3& ), $CellContext`threshold -> 
         1/50, $CellContext`history -> {}], "At 5% detected" -> 
       Association[$CellContext`Fun -> (
          Count[#, 2]/#3& ), $CellContext`threshold -> 
         1/20, $CellContext`history -> {}], "At 10% detected" -> 
       Association[$CellContext`Fun -> (
          Count[#, 2]/#3& ), $CellContext`threshold -> 
         1/10, $CellContext`history -> {}], "At 15% detected" -> 
       Association[$CellContext`Fun -> (
          Count[#, 2]/#3& ), $CellContext`threshold -> 
         3/20, $CellContext`history -> {}], "At 50% detected" -> 
       Association[$CellContext`Fun -> (
          Count[#, 2]/#3& ), $CellContext`threshold -> 
         1/2, $CellContext`history -> {}], 
       "At small change of detected" -> $CellContext`lsDetChangeSmall, 
       "At large change of detected" -> $CellContext`lsDetChangeLarge]; \
$CellContext`FirstLockdownStep[
       Pattern[$CellContext`strat, 
        Blank[]], 
       Pattern[$CellContext`courseOfEpidemics, 
        Blank[]], 
       Pattern[$CellContext`size, 
        Blank[]]] := 
     Block[{$CellContext`history, $CellContext`lss = $CellContext`strat, \
$CellContext`lockActive = False, $CellContext`val, $CellContext`j = 0}, 
       While[
         And[
          Not[$CellContext`lockActive], $CellContext`j < 
          Length[$CellContext`courseOfEpidemics]], 
         Increment[$CellContext`j]; $CellContext`val = \
$CellContext`lss[$CellContext`Fun][
            Part[$CellContext`courseOfEpidemics, $CellContext`j], 
            $CellContext`lss[$CellContext`history], $CellContext`size]; \
$CellContext`lockActive = $CellContext`val > \
$CellContext`lss[$CellContext`threshold]; AppendTo[
           $CellContext`lss[$CellContext`history], {$CellContext`j, \
$CellContext`val, $CellContext`lockActive}]; Null]; {$CellContext`j, 
         Part[$CellContext`courseOfEpidemics, $CellContext`j]}]; \
$CellContext`simulation[
       Pattern[$CellContext`net, 
        Blank[Graph]], 
       Pattern[$CellContext`initialList, 
        Blank[List]], 
       Pattern[$CellContext`\[Lambda], 
        Blank[]], 
       Pattern[$CellContext`g, 
        Blank[]], 
       Pattern[$CellContext`d, 
        Blank[]], 
       Pattern[$CellContext`o, 
        Blank[]], 
       Optional[
        Pattern[$CellContext`detCanInfect, 
         Blank[]], True], 
       Optional[
        Pattern[$CellContext`lockStrategy, 
         Blank[]], None], 
       Optional[
        Pattern[$CellContext`tmax, 
         Blank[]], 200]] := 
     Block[{$CellContext`networks = $CellContext`net, $CellContext`sizes, \
$CellContext`neighbours, $CellContext`det, $CellContext`inf, \
$CellContext`cases, $CellContext`tcourse, $CellContext`EndCondition, \
$CellContext`UpdateConditions, $CellContext`lss = $CellContext`lockStrategy, \
$CellContext`tmp, $CellContext`val, $CellContext`lockActive = 
        False}, $CellContext`sizes = 
        VertexCount[$CellContext`networks]; $CellContext`neighbours = \
$CellContext`neighboursOfVerticesList[$CellContext`networks]; \
$CellContext`EndCondition := 
        And[$CellContext`inf === 0, $CellContext`det === 
          0]; $CellContext`UpdateConditions[
          Pattern[$CellContext`list, 
           Blank[List]]] := ($CellContext`inf = 
          Count[$CellContext`list, 1]; $CellContext`det = 
          Count[$CellContext`list, 2]; $CellContext`list); $CellContext`cases[
         
          Pattern[$CellContext`i, 
           Blank[Integer]], 
          Pattern[$CellContext`j, 
           Blank[
           Integer]]] := ($CellContext`cases[$CellContext`i, $CellContext`j] = 
         Switch[
           $CellContext`cases[$CellContext`i - 1, $CellContext`j], 1, 
           
           RandomChoice[{$CellContext`g, $CellContext`d, 
              1 - $CellContext`g - $CellContext`d} -> {4, 5, 
              If[RandomReal[] < $CellContext`o, 2, 1]}], 2, 
           
           RandomChoice[{$CellContext`g, $CellContext`d, 
              1 - $CellContext`g - $CellContext`d} -> {4, 5, 2}], 3, 
           If[RandomReal[] > Product[
              
              If[$CellContext`cases[$CellContext`i - 1, $CellContext`u] < 
               If[$CellContext`detCanInfect, 3, 2], 
               1 - $CellContext`\[Lambda], 1], {$CellContext`u, 
               If[$CellContext`lockActive, {}, 
                Part[$CellContext`neighbours, $CellContext`j]]}], 1, 3], 4, 4,
            5, 5]); $CellContext`inf = 
        Count[$CellContext`initialList, 1]; $CellContext`det = 
        Count[$CellContext`initialList, 2]; 
       Do[$CellContext`cases[1, $CellContext`i] = 
         Part[$CellContext`initialList, $CellContext`i], {$CellContext`i, 1, 
          Length[$CellContext`initialList]}]; $CellContext`tcourse = 
        If[$CellContext`lss =!= None, 
          Table[
          If[$CellContext`EndCondition, Nothing, $CellContext`tmp = 
             If[Mod[$CellContext`i, 10] == 0, $CellContext`UpdateConditions, 
               Identity][
               Table[
                $CellContext`cases[$CellContext`i, $CellContext`j], \
{$CellContext`j, $CellContext`sizes}]]]; $CellContext`val = \
$CellContext`lss[$CellContext`Fun][$CellContext`tmp, 
              $CellContext`lss[$CellContext`history], $CellContext`sizes]; \
$CellContext`lockActive = $CellContext`val > \
$CellContext`lss[$CellContext`threshold]; AppendTo[
             $CellContext`lss[$CellContext`history], {$CellContext`i, \
$CellContext`val, $CellContext`lockActive}]; $CellContext`tmp, \
{$CellContext`i, $CellContext`tmax}], 
          Table[
           If[$CellContext`EndCondition, Nothing, 
            If[
            Mod[$CellContext`i, 10] == 0, $CellContext`UpdateConditions, 
             Identity][
             Table[
              $CellContext`cases[$CellContext`i, $CellContext`j], \
{$CellContext`j, $CellContext`sizes}]]], {$CellContext`i, \
$CellContext`tmax}]]; Append[
         Length[$CellContext`tcourse]][
         Append[$CellContext`sizes][
          
          Append[$CellContext`lss][{$CellContext`tcourse}]]]]; \
$CellContext`statify := {
       Count[#, 1], 
       Count[#, 2], 
       Count[#, 3], 
       Count[#, 4], 
       Count[#, 5]}& ; $CellContext`ticks = {{
       None, {{0, "0%"}, {0.1, "10%"}, {0.2, "20%"}, {0.3, "30%"}, {
         0.4, "40%"}, {0.5, "50%"}, {0.6, "60%"}, {0.7, "70%"}, {
         0.8, "80%"}, {0.9, "90%"}, {1, "100%"}}}, {
       Automatic, Automatic}}; $CellContext`StatPlot[
       Pattern[$CellContext`stats$, 
        Blank[]], 
       Pattern[$CellContext`i$, 
        Blank[]], 
       Pattern[$CellContext`tmax$, 
        Blank[]], 
       Pattern[$CellContext`groups$, 
        Blank[]], 
       Optional[
        Pattern[$CellContext`lds$, 
         Blank[]], {}], 
       Pattern[$CellContext`merge$, 
        Blank[]], 
       Pattern[$CellContext`merge2$, 
        Blank[]]] := Show[
       ListLinePlot[
        If[$CellContext`merge2$, $CellContext`mergeRD, Identity][
         If[$CellContext`merge$, $CellContext`mergeDI, Identity][
          Part[$CellContext`stats$, $CellContext`groups$]]], PlotStyle -> 
        If[$CellContext`merge2$, $CellContext`mergeRDcolor, Identity][
          If[$CellContext`merge$, $CellContext`mergeDIcolor, Identity][
           Part[
            Values[$CellContext`colors], $CellContext`groups$]]], 
        PlotRange -> {{1, $CellContext`tmax$}, {0, 1}}, AspectRatio -> 0.6, 
        ImageSize -> {$CellContext`previewSize, $CellContext`previewSize 0.6},
         Epilog -> {Thick, Dashed, 
          Line[{{$CellContext`i$, 0}, {$CellContext`i$, 1}}]}, Frame -> True, 
        FrameLabel -> {{None, None}, {None, None}}, 
        FrameTicks -> $CellContext`ticks, FrameStyle -> Directive[Black, 14]], 
       Apply[Sequence, 
        Table[
         ListLinePlot[
          If[$CellContext`merge2$, $CellContext`mergeRD, Identity][
           If[$CellContext`merge$, $CellContext`mergeDI, Identity][
            Part[
             Part[
              Part[$CellContext`lds$, $CellContext`k$$], 
              2], $CellContext`groups$]]], DataRange -> {
            Part[
             Part[$CellContext`lds$, $CellContext`k$$], 1], Part[
              Part[$CellContext`lds$, $CellContext`k$$], 1] + Length[
              Part[
               Part[
                Part[$CellContext`lds$, $CellContext`k$$], 2], 1]] - 1}, 
          PlotStyle -> Map[Directive[
             Part[{Dotted, Dashed, DotDashed}, 
              Mod[$CellContext`k$$, 2, 1]], 
             Nest[Lighter, #, $CellContext`k$$]]& , 
            If[$CellContext`merge2$, $CellContext`mergeRDcolor, Identity][
             If[$CellContext`merge$, $CellContext`mergeDIcolor, Identity][
              Part[
               Values[$CellContext`colors], $CellContext`groups$]]]], 
          PlotLegends -> Placed[{
             Part[
              Part[$CellContext`lds$, $CellContext`k$$], 3]}, {
             Part[{Left, Right}, 
              Mod[$CellContext`k$$, 2, 1]], Top}]], {$CellContext`k$$, 1, 
          Length[$CellContext`lds$]}]]]; $CellContext`mergeDI[{
        Pattern[$CellContext`inf, 
         Blank[]], 
        Pattern[$CellContext`det, 
         Blank[]], 
        Pattern[$CellContext`rest, 
         BlankNullSequence[]]}] := {$CellContext`inf + $CellContext`det, \
$CellContext`rest}; $CellContext`mergeDIcolor[{
        Pattern[$CellContext`inf, 
         Blank[]], 
        Pattern[$CellContext`det, 
         Blank[]], 
        Pattern[$CellContext`rest, 
         BlankNullSequence[]]}] := {
       Blend[{$CellContext`inf, $CellContext`det}], $CellContext`rest}; \
$CellContext`mergeDItext[{
        Pattern[$CellContext`inf, 
         Blank[]], 
        Pattern[$CellContext`det, 
         Blank[]], 
        Pattern[$CellContext`rest, 
         BlankNullSequence[]]}] := {
       StringJoin[$CellContext`inf, 
        "+", $CellContext`det], $CellContext`rest}; $CellContext`mergeRD[{
        Pattern[$CellContext`rest, 
         BlankNullSequence[]], 
        Pattern[$CellContext`rec, 
         Blank[]], 
        Pattern[$CellContext`dead, 
         Blank[]]}] := {$CellContext`rest, $CellContext`rec + \
$CellContext`dead}; $CellContext`mergeRDcolor[{
        Pattern[$CellContext`rest, 
         BlankNullSequence[]], 
        Pattern[$CellContext`rec, 
         Blank[]], 
        Pattern[$CellContext`dead, 
         Blank[]]}] := {$CellContext`rest, 
       Blend[{$CellContext`rec, $CellContext`dead}]}; \
$CellContext`mergeRDtext[{
        Pattern[$CellContext`rest, 
         BlankNullSequence[]], 
        Pattern[$CellContext`rec, 
         Blank[]], 
        Pattern[$CellContext`dead, 
         Blank[]]}] := {$CellContext`rest, 
       StringJoin[$CellContext`rec, 
        "+", $CellContext`dead]}; $CellContext`PadStats[
       Pattern[$CellContext`list, 
        Blank[]], 
       Pattern[$CellContext`len, 
        Blank[]]] := PadRight[$CellContext`list, $CellContext`len, 
       Part[$CellContext`list, -1]]; $CellContext`Sync = 
     False; $CellContext`maxn = 30^2; $CellContext`allowed = 
     Table[$CellContext`i^2, {$CellContext`i, 4, 
        Sqrt[$CellContext`maxn]}]; $CellContext`previewSize = 
     500; $CellContext`hardtmax = 100; $CellContext`saveDefs = True; 
    SetOptions[$FrontEndSession, DynamicEvaluationTimeout -> 
      30]; $CellContext`framerate = 2; $CellContext`ensembleSize = 
     10; $CellContext`groupAssoc = 
     Association[
      1 -> "inf", 2 -> "det", 3 -> "sus", 4 -> "rec", 5 -> 
       "dead"]; $CellContext`colors = 
     Association[
      1 -> Red, 2 -> Lighter[Orange], 3 -> Lighter[Gray], 4 -> 
       RGBColor[0.54, 1., 0.94], 5 -> Black]; $CellContext`regularParams = 
     Sequence[Alignment -> Center, ContinuousAction -> 
       True]; $CellContext`sliderParams = 
     Sequence[
      Appearance -> 
       "DownArrow", $CellContext`regularParams]; $CellContext`animParams = 
     Sequence[AppearanceElements -> {
        "ProgressSlider", "PlayPauseButton", "ResetButton", "StepLeftButton", 
         "StepRightButton", "FasterSlowerButtons"}, AnimationRunning -> False,
        AnimationRepetitions -> 1, DisplayAllSteps -> True, ImageSize -> 850, 
       DisplayAllSteps -> True, Appearance -> {"Labeled"}]; $CellContext`cost[
      
       Pattern[$CellContext`val, 
        Blank[]], {
        Pattern[$CellContext`min, 
         Blank[]], 
        Pattern[$CellContext`max, 
         Blank[]], 
        Pattern[$CellContext`step, 
         Blank[]]}] := Min[
       Max[
        Round[$CellContext`val, $CellContext`step], $CellContext`min], \
$CellContext`max]; 
    SetAttributes[$CellContext`sl, HoldRest]; $CellContext`sl[{
        Pattern[$CellContext`ss, 
         Blank[]], 
        Pattern[$CellContext`min, 
         Blank[]], 
        Pattern[$CellContext`max, 
         Blank[]], 
        Optional[
         Pattern[$CellContext`step, 
          Blank[]], 0.001], 
        Optional[
         Pattern[$CellContext`enabled, 
          Blank[]], True]}, 
       Optional[
        Pattern[$CellContext`post, 
         Blank[]], Identity]] := Row[{
        Slider[
         Dynamic[$CellContext`ss, {($CellContext`ss = #)& , $CellContext`post& \
}], {$CellContext`min, $CellContext`max, $CellContext`step}, 
         Enabled -> $CellContext`enabled], "       ", 
        InputField[
         Dynamic[
          If[
           IntegerQ[$CellContext`step], 
           IntegerPart[$CellContext`ss], 
           
           SetAccuracy[$CellContext`ss, 
            4]], {($CellContext`ss = #)& , ($CellContext`ss = #; If[
             NumericQ[$CellContext`ss], $CellContext`post])& }], Number, 
         FieldSize -> {4, 1}, Enabled -> $CellContext`enabled]}]; 
    SetAttributes[$CellContext`slN, HoldRest]; $CellContext`slN[{
        Pattern[$CellContext`ss, 
         Blank[]], 
        Optional[
         Pattern[$CellContext`enabled, 
          Blank[]], True], 
        Pattern[$CellContext`allowed, 
         Blank[]]}, 
       Optional[
        Pattern[$CellContext`post, 
         Blank[]], Identity]] := Row[{
        Slider[
         Dynamic[$CellContext`ss, {($CellContext`ss = #)& , $CellContext`post& \
}], {$CellContext`allowed}, Enabled -> $CellContext`enabled], "       ", 
        InputField[
         Dynamic[
          
          IntegerPart[$CellContext`ss], {($CellContext`ss = #)& , \
($CellContext`ss = First[
              Nearest[$CellContext`allowed, #]]; If[
             NumericQ[$CellContext`ss], $CellContext`post]; Null)& }], Number,
          FieldSize -> {4, 1}, Enabled -> $CellContext`enabled]}]; 
    SetAttributes[$CellContext`hg, HoldRest]; $CellContext`hg[{
        Pattern[$CellContext`ss, 
         Blank[]], 
        Pattern[$CellContext`col, 
         Blank[Integer]], 
        Optional[
         Pattern[$CellContext`min, 
          Blank[]], 0.001], 
        Optional[
         Pattern[$CellContext`max, 
          Blank[]], 0.3], 
        Optional[
         Pattern[$CellContext`step, 
          Blank[]], 0.001]}, 
       Pattern[$CellContext`post, 
        Blank[]]] := Row[{
        HorizontalGauge[
         Dynamic[$CellContext`ss, {($CellContext`ss = #)& , $CellContext`post& \
}], {$CellContext`min, $CellContext`max}, 
         GaugeStyle -> $CellContext`colors[$CellContext`col], PerformanceGoal -> 
         "Speed", ScaleDivisions -> {10, 10}, GaugeLabels -> None, 
         ScalePadding -> {0.1, 0}, ImageSize -> {230, 32}, 
         ScaleOrigin -> {0, {0, 1}}, GaugeFrameSize -> None], 
        InputField[
         Dynamic[
          
          SetAccuracy[$CellContext`ss, 
           4], {($CellContext`ss = #)& , ($CellContext`ss = \
$CellContext`cost[#, {$CellContext`min, $CellContext`max, $CellContext`step}]; 
           If[
             NumericQ[$CellContext`ss], $CellContext`post])& }], Number, 
         FieldSize -> {4, 1}]}]; $CellContext`n$$ = 
     25; $CellContext`network$$ = "Grid"; $CellContext`\[Rho]$$ = 
     0.2; $CellContext`k$$ = 2; $CellContext`p$$ = 3; $CellContext`t$$ = 
     1; $CellContext`\[Lambda]$$ = 0.2; $CellContext`o$$ = 
     0.05; $CellContext`d$$ = 0.005; $CellContext`g$$ = 
     0.01; $CellContext`detCanInfect$$ = 
     True; $CellContext`groups$$ = {1, 2, 3, 4, 
      5}; $CellContext`tmax$$ = $CellContext`hardtmax; $CellContext`merge$$ = 
     False; $CellContext`merge2$$ = False; $CellContext`c$$[
     "refreshColors"]; $CellContext`c$$["all"]))]], "Output",
 CellLabel->"Out[1]=",
 CellID->883252411,ExpressionUUID->"a9a582a9-7820-4012-bb9f-b663627e2297"]
}, {2}]]
}, Open  ]]
},
WindowSize->{1440, 855},
WindowMargins->{{0, Automatic}, {Automatic, 0}},
PrivateNotebookOptions->{"CloudPublishPath"->"Experiments.nb"},
FrontEndVersion->"12.2 for Mac OS X x86 (64-bit) (December 12, 2020)",
StyleDefinitions->"Default.nb",
ExpressionUUID->"cc28359a-a04c-4add-8ad6-9045d5cdecf2"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1510, 35, 120, 1, 67, "Section",ExpressionUUID->"2daafac9-dd3f-47a6-8226-e0800096b956",
 CellID->296662264],
Cell[CellGroupData[{
Cell[1655, 40, 120539, 2756, 7683, "Input",ExpressionUUID->"51a44a3f-ad0e-46da-a77e-94c697082644",
 CellID->692615483],
Cell[122197, 2798, 167600, 3650, 973, "Output",ExpressionUUID->"a9a582a9-7820-4012-bb9f-b663627e2297",
 CellID->883252411]
}, {2}]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature FuDWJl9hxIK4nAwVQVpG46AW *)
