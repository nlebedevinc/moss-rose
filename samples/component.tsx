import { useEffect, useState } from 'react'
import type { Palette } from './palette'

interface Props {
  name: string
  onLoad?: (palette: Palette) => void
}

const RETRIES = 3

// Loads a palette by name and shows its swatches.
export function Swatches({ name, onLoad }: Props) {
  const [palette, setPalette] = useState<Palette | null>(null)

  useEffect(() => {
    fetch(`/themes/${name}.json`)
      .then(res => (res.ok ? res.json() : Promise.reject(res.status)))
      .then((data: Palette) => { setPalette(data); onLoad?.(data) })
      .catch(err => console.error('load failed', err))
  }, [name])

  if (!palette) return <p className="hint">Loading…</p>
  return (
    <ul data-count={Object.keys(palette).length}>
      {Object.entries(palette).map(([key, hex]) => (
        <li key={key} style={{ color: hex }}>{key}</li>
      ))}
    </ul>
  )
}
