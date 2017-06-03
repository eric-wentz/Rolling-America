
function Get-DicePool {
$DiceColors = (@("P","R","Y","B","G","O","A") | Sort-Object {Get-Random})
$DiceValues = @(1..6 | ForEach-Object {Get-Random -Minimum 1 -Maximum 7})
Return @(0..5 | ForEach-Object {"$($DiceColors[$_])$($DiceValues[$_])"})
}

function Get-Placement 
($NodesToConsider)
{
$bestFit = ""
#Write-Debug "Considering $NodesToConsider"
$nodeCollection | ForEach-Object {
if ($_.Name -in $NodesToConsider){
#Write-Debug "Considering $($_.Name)"
if($_.Possible_Values.length -eq 1){Write-Debug "Perfect for $($_.Name)";$bestFit = $_.Name}
ElseIf ($_.Possible_Values.length -eq 2 -and !$bestFit){Write-Debug "Great for $($_.Name)"; $bestFit =  $_.Name}
ElseIf ($_.Possible_Values.length -eq 3 -and !$bestFit){Write-Debug "Good for $($_.Name)"; $bestFit =  $_.Name}

if(!$bestFit){
$openValues = 0
$_.Neighbors | ForEach-Object {
$neighborToConsider=$_
$openValues += ($nodeCollection |Where-Object {$_.Name -eq $neighborToConsider} | ForEach-Object {$_.Possible_Values.count})
}
if($openValues -lt $currentBestNumber -or $currentBestNumber -eq $null){
$currentBest = $_.Name
$currentBestNumber = $openValues
} Elseif ($openValues -eq $currentBestNumber -and (get-random -Minimum 0 -Maximum 2) -eq 1){
$currentBest = $_.Name
$currentBestNumber = $openValues
}
}
}
}
if(!$bestFit){Write-Debug "Using Neighbor Consideration"
$bestFit = $currentBest}
if(!$bestFit){Write-Debug "Choosing Randomly"
$bestFit = $NodesToConsider[0]}
$bestFit
}

cls
#Initialize Metrics
$numberInvalidsRolls = 0 
$numberValidRollsPlaced = 0
$DicePool = @()
#PopulateMap
$nodeNames = @("P1","P2","P3","P4","P5","P6","P7","P8","R9","R10","R11","R12","R13","R14","R15","R16","R17","Y18","Y19","Y20","Y21","Y22","Y23","Y24","Y25","B26","B27","B28","B29","B30","B31","B32","B33","B34","G35","G36","G37","G38","G39","G40","G41","O42","O43","O44","O45","O46","O47","O48","O49","O50")
$nodeNeighbors = @(("P2"),("P1","P3","P5"),("P2","P4","P5"),("P3","P5","P6","P8","R10"),("P2","P3","P4","P6","P7"),("P4","P8","P5","P7"),("P5","P6"),("P4","P6","R9","R10"),("P8","R10","R12"),("P4","P8","R9","R11","R12","R13","R14"),("R10","R14","Y18","B26","B31"),("R9","R10","R13"),("R10","R12","R14","R15","Y18","Y20"),("R10","R11","R13","Y18"),("R13","R16","R17","Y20"),("R15","R17"),("R15","R16","Y20","Y22","Y24"),("R11","R13","R14","B31","B32","Y19","Y20"),("Y18","Y20","Y21","B32","B33","G35","G37","G39"),("R13","R15","R17","Y18","Y19","Y21","Y22","Y23"),("Y19","Y20","Y23","Y25","G39","G41"),("R17","Y20","Y23","Y24"),("Y20","Y21","Y22","Y25"),("R17","Y22"),("Y21","Y23","G41"),("R11","B27","B31"),("B26","B28","B32","B33"),("B27","B29","B33","B34"),("B28","B30","B34"),("B29","B34","G36","O43"),("R11","Y18","B26","B32"),("Y18","Y19","B27","B31","B33"),("B27","B28","B32","Y24","Y19","G35"),("B28","B29","B30","B33","G35","G36"),("Y19","B33","B34","G36","G37","G38"),("B30","B34","G35","G38","O43","O46"),("Y19","G35","G38","G39"),("G35","G36","G37","G39","G40","O46"),("Y19","Y21","G37","G38","G40","G41"),("G38","G39","G41","O49"),("Y21","Y25","G39","G40"),("q99"),("B30","G36","O44","O45","O46","O47"),("O43","O45"),("O43","O44","O47","O48"),("G36","G38","O43","O47","O49"),("O43","O45","O46","O48","O49"),("O45","O47","O49"),("G40","O46","O47","O48"),("q99"))
$nodeCollection = @()
$nodeCollection = (1..$nodeNames.Length | ForEach-Object {
$node = New-Object PSObject
Add-Member -InputObject $node -MemberType NoteProperty -Name Name -Value $nodeNames[$_ - 1]
Add-Member -InputObject $node -MemberType NoteProperty -Name Neighbors -Value $nodeNeighbors[$_ - 1]
Add-Member -InputObject $node -MemberType NoteProperty -Name Value -Value ""
Add-Member -InputObject $node -MemberType NoteProperty -Name Possible_Values -Value @(1..6)
$node
}
)
#NumberOfTurns
1..48 | ForEach-Object{
#Check If any Dice are available
if($DicePool.Length -lt 1){
$DicePool = Get-DicePool
#Reshuffle Dice
"Shuffling Dice for New Round"
}

#GetNextDie
$thisDie = $DicePool[0]
$currentDieColor = $thisDie.substring(0,1)
[int]$currentDieValue = $thisDie.substring(1,1)
$DicePool = $DicePool -ne $thisDie
#"Trying to Place a $thisDie"

#Collect Nodes for Legal Placement
$possibleNodes = @()
$nodeCollection | ForEach-Object {
  if(($_.Possible_Values).Contains($currentDieValue) -and (($_.Name).startsWith($currentDieColor) -or $currentDieColor -eq "A")){
    $possibleNodes += ($_.Name)
  }
}

if($possibleNodes.Length -ne 0){
#  $placementName = ($possibleNodes[(get-random -minimum 0 -maximum ($possibleNodes.Length))])
#  $placementName = ($possibleNodes[0])

  $placementName = (Get-Placement -NodesToConsider $possibleNodes)
}Else {
  "Cannot Place  a $thisDie."
  $placementName = "P0"
  $numberInvalidsRolls++
}

$nodeCollection | ForEach-Object {
  if($_.Name -eq $placementName){
    $_.Value = $currentDieValue
    $_.Possible_Values = @()
    "Placed a $thisDie in $placementName"
    $numberValidRollsPlaced++
    $_.Neighbors | ForEach-Object {
      $thisNeighbor = $_
      $nodeCollection | ForEach-Object {
        if($_.Name -eq $thisNeighbor -and $_.Possible_Values -ne ""){
          #"A Neighbor $($_.Name) with open spots"
          $_.Possible_Values = @($_.Possible_Values | Where-Object {$currentDieValue -eq $_ -or ($currentDieValue + 1) -eq $_ -or ($currentDieValue - 1) -eq $_})
          }
        }
      }
    }
  }
  #check for nodes with no possible values
      $nodeCollection | ForEach-Object {
        if($_.Possible_Values.length -eq 0 -and $_.Value -eq ""){
          #"Found $($_.Name) with no possible values."
          $_.Value = '0'
          }
        }
}
$nodeCollection
"$numberInvalidsRolls Invalid"
"$numberValidRollsPlaced Valid"
