package controllers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"bitbucket.org/vdumeaux/mixt/mixt/mixt"

	"github.com/fjukstad/kvik/utils"
	"github.com/gorilla/mux"
)

func SearchHandler(w http.ResponseWriter, r *http.Request) {
	if !LoggedIn(r) {
		http.Redirect(w, r, "/", 302)
		return
	}

	vars := mux.Vars(r)
	term := vars["term"]
	result, err := SearchForGene(term)
	if err != nil {
		fmt.Println("Search went bad:", err)
		http.Error(w, err.Error(), 500)
	}
	res := utils.SearchResponse{result}
	b, _ := json.Marshal(res)
	w.Write(b)
}

var genes []string

func SearchForGene(searchTerm string) ([]string, error) {
	var err error
	if len(genes) < 1 {
		genes, err = mixt.GetGenes()
		if err != nil {
			return []string{}, err
		}
	}

	var result []string
	for _, gene := range genes {
		a := strings.ToLower(gene)
		b := strings.ToLower(searchTerm)
		if strings.Contains(a, b) {
			geneFmt := strings.Trim(gene, "\"")
			result = append(result, geneFmt)
		}
	}
	return result, nil
}