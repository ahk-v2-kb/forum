class FileMap extends Map
{
	/*
		Store file names in a plain Map as keys tied to 'DUMMY' values.
		The Map will automatically sort its keys lexicographically.
	*/
	Files := Map()

	/*
		Instantiate a new, empty FileMap or
		parse a string array of file paths and initialize it with them.
	*/
	__New(Paths := '')
	{
		if IsObject(Paths)
			for path in Paths
				this.Insert(path)
	}

	/*
		Parse and insert a single string file path.
	*/
	Insert(path)
	{
		SplitPath(path, fileName, folderPath)

		for folder in StrSplit(folderPath, '\')
		{
			; Insert a folder name into the map
			; if no such name has been inserted yet.
			if !this.Has(folder)
				this[folder] := FileMap.New()

			; Walk the chain of folders,
			; always retrieving the next descendant.
			this := this[folder]
		}

		; Lastly, store the file name in the internal files map.
		; The value it's associated to is of little importance.
		this.Files[fileName] := 'DUMMY'
	}

	/*
		Stringify the contents of the FileMap
		with a delimiter of your choosing (default newline).
	*/
	PrintSorted(delimiter := '`n')
	{
		result := ''

		; Lexical scope capturing of 'result'.
		PrintSelf(FM, rootFolder := '')
		{
			; Always print files first (if any).
			for file in FM.Files
				result .= rootFolder file delimiter

			; Traverse the chain of folders.
			; Concat with '\'.
			for currentFolder, NextFM in FM
				PrintSelf(NextFM, rootFolder currentFolder '\')
		}

		PrintSelf(this)

		return result
	}
}

Paths := StrSplit('
(
	c:\folder a\subfolder a\abcd.txt
	c:\folder a\wfbt.txt
	c:\folder a\subfolder a\Abcd.txt
	c:\folder c\blah.txt
	c:\folder a\subfolder a\wxyz.txt
	c:\folder b\terp.txt
	c:\folder b\subfolder c\phbt.txt
	c:\folder a\subfolder a\hfbt.txt
)', '`n')

MyFileMap := FileMap.New(Paths)
MsgBox(MyFileMap.PrintSorted())