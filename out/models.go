package out

import "github.com/crdant/cf-rename-resource"

type Request struct {
	Source resource.Source `json:"source"`
	Params Params          `json:"params"`
}

type Params struct {
	CurrentName string `json:"current"`
	NewName     string `json:"new"`
}

type Response struct {
	Version  resource.Version        `json:"version"`
	Metadata []resource.MetadataPair `json:"metadata"`
}
