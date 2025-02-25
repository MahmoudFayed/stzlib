
# Python Transformation Function (Updated)
$cPyToRingDataTransFunc = '
def transform_to_ring(data):
    def _transform(obj):
        if isinstance(obj, dict):
            items = []
            for key, value in obj.items():
                items.append(f"[\'+char(39)+'{key}\'+char(39)+', {_transform(value)}]")
            return "[" + ", ".join(items) + "]"
        elif isinstance(obj, list):
            return "[" + ", ".join(_transform(item) for item in obj) + "]"
        elif isinstance(obj, str):
            return f"\'+char(39)+'{obj}\'+char(39)+'"
        elif isinstance(obj, (int, float)):
            return str(obj)
        else:
            return f"\'+char(39)+'{str(obj)}\'+char(39)+'"
    return _transform(data)
'

$cRToRingDataTransFunc = '
transform_to_ring <- function(data) {
  transform <- function(obj, depth = 0) {
    # Prevent excessive recursion
    if (depth > 100) {
      return("TOO_DEEP")
    }
    
    # Handle NULL and NA values explicitly
    if (is.null(obj)) {
      return("NULL")
    }
    
    # Handle lists or data frames
    if (is.list(obj) || is.data.frame(obj)) {
      items <- lapply(seq_along(obj), function(i) {
        key <- names(obj)[i]
        value <- transform(obj[[i]], depth + 1)
        if (!is.null(key)) {
          sprintf("['+char(39)+'%s'+char(39)+', %s]", key, value)
        } else {
          value
        }
      })
      return(paste0("[", paste(items, collapse=", "), "]"))
    }
    
    # Handle vectors or arrays
    if (is.vector(obj) || is.array(obj)) {
      if (length(obj) > 1) {
        items <- sapply(obj, function(x) {
          if (is.na(x)) return("NULL") # Changed from "NA" to "NULL"
          transform(x, depth + 1)
        })
        return(paste0("[", paste(items, collapse=", "), "]"))
      } else {
        if (is.na(obj)) return("NULL") # Changed from "NA" to "NULL"
      }
    }
    
    # Handle character strings
    if (is.character(obj)) {
      return(sprintf("'+char(39)+'%s'+char(39)+'", obj))
    }
    
    # Handle numeric values
    if (is.numeric(obj)) {
      return(as.character(obj))
    }
    
    # Handle logical values
    if (is.logical(obj)) {
      return(ifelse(obj, "TRUE", "FALSE"))
    }
    
    # Default case
    return(sprintf("'+char(39)+'%s'+char(39)+'", as.character(obj)))
  }
  
  transform(data, depth = 0)
}
'

class StzExtCodeXT
    @aLanguages = [
        :python = [
            :name = "Python",
            :type = "interpreted",
            :extension = ".py",
            :runtime = "python",
            :alternateRuntimes = ["python3", "py"],
            :datafile = "pydata.txt",
            :customPath = "",
            :transformFunction = $cPyToRingDataTransFunc,
            :cleanup = TRUE
        ],
        :r = [
            :name = "R",
            :type = "interpreted",
            :extension = ".R",
            :runtime = "Rscript",
            :alternateRuntimes = ["R"],
            :datafile = "rdata.txt",
            :customPath = "",
            :transformFunction = $cRToRingDataTransFunc,
            :cleanup = TRUE
        ]
    ]

    @aCallTrace = []
    @cLanguage = ""
    @cCode = ""
    @cSourceFile = ""
    @cOutputFile = "output.txt"  # New: For capturing output/errors
    @cDataFile = ""
    @nStartTime = 0
    @nEndTime = 0
    @bVerbose = FALSE  # New: Debugging flag

    def Init(cLang)
        if NOT This.IsLanguageSupported(cLang)
            stzraise("Language '" + cLang + "' is not supported")
        ok
        @cLanguage = lower(cLang)
        @cSourceFile = "temp" + @aLanguages[@cLanguage][:extension]
        @cDataFile = @aLanguages[@cLanguage][:datafile]

    def IsLanguageSupported(cLang)
        return @aLanguages[lower(cLang)] != NULL

    def SetRuntimePath(cPath)
        @aLanguages[@cLanguage][:customPath] = cPath

    def SetCode(cNewCode)
        @cCode = cNewCode

    def SetVerbose(bVerbose)
        @bVerbose = bVerbose

    def Prepare()
        remove(@cSourceFile)
        remove(@cDataFile)
        This.WriteToFile(@cSourceFile, This.PrepareSourceCode())

    def Execute()

        This.Prepare()

        if @cCode = ""
            return
        end

        @nStartTime = clock()
        cWorkDir = ring_substr2(@cSourceFile, "\\" + @aLanguages[@cLanguage][:extension], "")
        chdir(cWorkDir)

        cCmd = This.BuildCommand() + " > " + @cOutputFile + " 2>&1"
        nExitCode = system(cCmd)

        @nEndTime = clock()

        cOutput = This.ReadFile(@cOutputFile)

        This.RecordExecution(cOutput, nExitCode)

        if @bVerbose
            ? "Command: " + cCmd
            ? "Exit Code: " + nExitCode
            ? "Output: " + cOutput
        end

	def Run()
		This.Execute()

	def Exec()
		This.Execute()

/*    def Output()
        if len(@aCallTrace) = 0
            return ""
        ok
        return @aCallTrace[len(@aCallTrace)][:output]
*/
    def LastCallDuration()
        if len(@aCallTrace) > 0
            return @aCallTrace[len(@aCallTrace)][:duration]
        end
        return 0

    def Output()
        if NOT fexists(@cDataFile)
            stzraise("File does not exist!")
        ok
        cContent = This.ReadFile(@cDataFile)
        if cContent = NULL or cContent = ""
            return ""
        end
        try
            cCode = 'result = ' + cContent
            eval(cCode)
            return result
        catch
            ? "Eval error: " + cCatchError
            return cContent
        end

	def Result()
		return This.Output()

    def FileName()
        return @cDataFile

    def CallTrace()
        return @aCallTrace

    PRIVATE

    def WriteToFile(cFile, cContent)
        fp = fopen(cFile, "w")
        fwrite(fp, cContent)
        fclose(fp)

    def ReadFile(cFile)
        if NOT fexists(cFile)
            return NULL
        ok
        fp = fopen(cFile, "r")
        if fp = NULL
            return NULL
        end
        cContent = fread(fp, fsize(fp))
        fclose(fp)
        return cContent

    def BuildCommand()
        if @aLanguages[@cLanguage][:type] = "interpreted"
            cCmd = ""
            if @aLanguages[@cLanguage][:customPath] != ""
                cCmd = @aLanguages[@cLanguage][:customPath] + " " + @cSourceFile
            else
                cCmd = @aLanguages[@cLanguage][:runtime] + " " + @cSourceFile
            ok
            return cCmd
        else
            stzraise("Only interpreted languages are currently supported!")
        ok

    def RecordExecution(cOutput, nExitCode)
        cMode = ""
        if @aLanguages[@cLanguage][:type] = "interpreted"
            cMode = "interpreted"
        else
            stzraise("Only interpreted languages are currently supported!")
        ok
        @aCallTrace + [
            :language = @cLanguage,
            :timestamp = TimeStamp(),
            :duration = (@nEndTime - @nStartTime) / clockspersecond(),
            :output = cOutput,
            :exitcode = nExitCode,
            :mode = cMode
        ]

    def PrepareSourceCode()
        cTransformFunction = @aLanguages[@cLanguage][:transformFunction]
        if @cLanguage = "python"
            cFullCode = NL + cTransformFunction + '
# Main code
print("Python script starting...")
' + @cCode + '
print("Data before transformation:", data)
transformed = transform_to_ring(data)
print("Data after transformation:", transformed)
with open("' + @cDataFile + '", "w") as f:
    f.write(transformed)
print("Data written to file")
'
            return cFullCode

        but @cLanguage = "r"
            cFullCode = cTransformFunction + '
# Main code
cat("R script starting...\n")
' + @cCode + '
transformed <- transform_to_ring(data)
writeLines(transformed, "' + @cDataFile + '")
cat("Data written to file\n")
'
            return cFullCode
        else
            stzraise("Not implemented yet for this language!")
        ok
