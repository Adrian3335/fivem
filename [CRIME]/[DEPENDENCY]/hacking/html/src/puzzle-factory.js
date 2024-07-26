import { randomInt, sample } from './helpers.js'
import TRANSLATIONS from './language.js'

const selectedLang = TRANSLATIONS.SELECTED_LANGUAGE

if(!TRANSLATIONS.LANGUAGES.includes(selectedLang)) console.log(`LANGUAGE NOT SUPPORTED\nSELECTED: ${TRANSLATIONS.SELECTED_LANGUAGE}\nAVAILABLE: ${TRANSLATIONS.LANGUAGES}`)
const LANG = TRANSLATIONS[selectedLang]

const SHAPES = ["kwadrat", "trojkat", "prostokat", "kolo"]
const COLORABLE = ['background', 'text', 'number', 'shape']

const COLOR_CODES = ['black', 'white','#146aff','#ff142c','#ffff2b','#fca708','#0ed907','#ae07e6']
const LANG_COLORS = LANG.COLORS.reduce((obj, key, i) => {obj[key] = COLOR_CODES[i]; return obj}, {})


const COLORS = {
    'black' : 'black',
    'white' : 'white', 
    'blue' : '#146aff',
    'red' : '#ff142c',
    'yellow' : '#ffff2b',
    'orange' : '#fca708',
    'green' : '#0ed907',
    'purple' : '#ae07e6',
}
const QUESTIONS = {
    'kolor tla' : (d) => d.colors['background'],
    'napisany kolor' : (d) => d.colors['text'],
    'kolor numeru' : (d) => d.colors['number'],
    'kolor ksztaltu' : (d) => d.colors['shape'],
    'kolor tekstu' : (d) => d.text[0],
    'tekst nad kolorem' : (d) => d.text[1],
    'ksztalt pod tekstem' : (d) => d.shape
}

class PuzzleData {
    constructor(shape, number, text, colors) {
      this.shape = shape
      this.number = number
      this.text = text
      this.colors = colors
    }
}

// generates a random puzzle
export function generateRandomPuzzle(){

    const shape = sample(SHAPES)
    const number = randomInt(9) + 1

    const topText = sample(Object.keys(LANG_COLORS))
    const bottomText = sample(SHAPES)

    const colors = COLORABLE.reduce((obj, color) => {obj[color] = sample(Object.keys(COLORS)); return obj}, {})

    // ensure shape and background don't blend
    while(colors['text'] == colors['background'])
        colors['text'] = sample(Object.keys(COLORS))

    // ensure nothing blends with shape
    while(['background', 'text', 'number'].map(i => colors[i]).includes(colors['shape']))
        colors['shape'] = sample(Object.keys(COLORS))
    
    return new PuzzleData(shape, number, [topText, bottomText], colors)
}


export function generateQuestionAndAnswer(nums, puzzles){

    const positionOne = randomInt(nums.length)
    let tempPosTwo
    do {tempPosTwo = randomInt(nums.length)} while(positionOne == tempPosTwo) 
    const positionTwo = tempPosTwo
    

    const firstQuestion = sample(Object.keys(QUESTIONS))
    let tempSecondQuestion
    do {tempSecondQuestion = sample(Object.keys(QUESTIONS))} while(tempSecondQuestion == firstQuestion) 
    const secondQuestion = tempSecondQuestion

    puzzles = puzzles.map(convertPuzzleDataLang)

    // this is confusing as hell, but works somehow
    const question =  `${firstQuestion} (${nums[positionOne]}) ORAZ ${secondQuestion} (${nums[positionTwo]})`
    const answer = QUESTIONS[firstQuestion](puzzles[positionOne]) + ' ' + QUESTIONS[secondQuestion](puzzles[positionTwo])
console.log(answer)
    return [question, answer]
}


// LANGUAGE TRANSLATION FUNCTIONS 
// Should implement a more robust method for all text, but this is a start

// takes in a puzzleData class and converts language of colors
function convertPuzzleDataLang(puzzle){
    const result = puzzle
    puzzle.colors.background = convertColor(puzzle.colors.background)
    puzzle.colors.number = convertColor(puzzle.colors.number)
    puzzle.colors.shape = convertColor(puzzle.colors.shape)
    puzzle.colors.text = convertColor(puzzle.colors.text)
    puzzle.text = puzzle.text.map(i => isColor(i) ? convertColor(i) : i)
    return result
}

const isColor = (string) => TRANSLATIONS.EN.COLORS.includes(string)

function convertColor(originalColor){
    const englishColors = TRANSLATIONS.EN.COLORS
    const position = englishColors.indexOf(originalColor)
    return LANG.COLORS[position]
}
