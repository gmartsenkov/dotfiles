#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as str])


(defn sketchybar-set
  [output]
  (sh "sketchybar" "--set" "calendar" (str "label=" output)))


(let [events (-> (sh "icalBuddy" "-ea" "-n" "-nc" "-iep" "title,datetime" "-s" "-b" "" "eventsToday")
                 :out
                 (str/split #"\n")
                 (->> (map str/trim))
                 (->> (partition 2)))]
  (if (empty? events)
    (sketchybar-set "No events for today")
    (sketchybar-set (str "[" (count events) "]" " Next Event: " (-> events (first) (last))))))
