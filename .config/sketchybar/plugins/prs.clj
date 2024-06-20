#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[cheshire.core :as json])


(defn sketchybar-set
  [output]
  (sh "sketchybar" "--set" "prs" (str "label=" output)))


;; gh search prs --state=open --review-requested=@me --json id
(let [prs (-> (sh "gh" "search" "prs" "--state" "open" "--review-requested" "@me" "--json" "id")
              :out
              (json/parse-string true))]
  (sketchybar-set (count prs)))
